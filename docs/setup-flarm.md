# ADS-B and FLARM

Small document targeted for gliders to get up and running with ADS-B and FLARM.
Automated installation can be found at https://github.com/mgomersbach/ogn_install
This document describes approximately the steps taken in the automated installer.

## What

Get Raspberry Pi up and running with Raspbian as Operating System, RTL-SDR dongle as signal receiver and OGN or FR24 and FlightAware as output (The latter two giving you enterprise/pro account for their services)

## How

Many dongles and Operating Systems will work, these are recommended for a quick setup.
A second dongle is recommended when one wants to do ADB-B and OGN/Flarm at the same time.
It is possible however to have a cron in place that ensures Flarm on gliding conditions and ADS-B outside of that timeframe.
This is an important feature for flying clubs that can/will not afford a second one.

## Installation

The following instructions assume as Raspbian install

### Buy Raspberry Pi

See https://www.amazon.de/s?k=raspberry+pi

### Buy RTL-SDR Dongle (and antenna) or 2

see https://www.amazon.de/s?k=rtl+sdr+r820t2

### Download OS

see https://downloads.raspberrypi.org/NOOBS_latest

### Install OS

https://www.raspbian.org/
https://downloads.raspberrypi.org/imager/imager.exe
https://downloads.raspberrypi.org/imager/imager.dmg
https://downloads.raspberrypi.org/imager/imager_amd64.deb
https://downloads.raspberrypi.org/NOOBS_latest

or see https://thepi.io/how-to-install-noobs-on-the-raspberry-pi/

### Update system_packages

```sh
sudo apt update -y
sudo apt upgrade -y
```

### Blacklist DVB-T modules

```sh
sudo nano /etc/modprobe.d/blacklist-dvbt.conf
```

```content
blacklist rtl8192cu
blacklist rtl8xxxu
blacklist dvb_usb_rtl28xxu
blacklist e4000
blacklist rtl2832
blacklist r820t
blacklist rtl2830
blacklist dvb_usb_rtl28xxu
blacklist dvb_usb_rtl2832u
```

Write to file with ctrl+o and exit with ctrl+x

### Install OGN packages

```sh
sudo apt-get install rtl-sdr -y
sudo apt-get install libconfig9 libjpeg8 libfftw3-dev lynx ntpdate ntp -y
sudo wget http://download.glidernet.org/rpi-gpu/rtlsdr-ogn-bin-RPI-GPU-latest.tgz -O /tmp/rtlsdr-ogn-bin.tgz
sudo tar xvzf /tmp/rtlsdr-ogn-bin.tgz -C /opt
```

### Create OGN user

```sh
useradd -M -r ogn -s /usr/sbin/nologin
```

### Create OGN fifo

```sh
mkfifo /opt/rtlsdr-ogn/ogn-rf.fifo
```

### Create GPU device node

```sh
mknod /dev/gpu_dev c 100 0
```

### Create OGN Configuration

Replace [OGN_CALLSIGN] with... your call-sign.

```sh
sudo nano /opt/rtlsdr-ogn/[OGN_CALLSIGN].conf
```

Replace [OGN_*] occurrences from:
OGN_CALLSIGN:

  Station name: up to 9 characters
  See http://wiki.glidernet.org/receiver-naming-convention

OGN_LATITUDE OGN_LONGITUDE OGN_GEOIDSEPAR OGN_FREQCORR OGN_GSMCENTERFREQ OGN_GSMGAIN:

  Station coordinates, frequency offset and GSM parameters
  See http://wiki.glidernet.org/wiki:raspberry-pi-installation

```content
RF:
{
  FreqCorr = [OGN_FREQCORR]; # [ppm] "big" R820T sticks have 40-80ppm correction factors, measure it with gsm_scan
  GSM: # for frequency calibration based on GSM signals
  {
    CenterFreq = [OGN_GSMCENTERFREQ]; # [MHz] find the best GSM frequency with gsm_scan
    Gain       = [OGN_GSMGAIN]; # [dB]  RF input gain (beware that GSM signals are very strong !)
  };
};

Position:
{
  Latitude   = [OGN_LATITUDE]; # [deg] Antenna coordinates
  Longitude  = [OGN_LONGITUDE]; # [deg]
  Altitude   = [OGN_ALTITUDE]; # [m] Altitude above sea leavel
  GeoidSepar = [OGN_GEOIDSEPAR]; # [m] Geoid separation: FLARM transmits GPS altitude, APRS uses means Sea level altitude
};

APRS:
{
  # Please refer to http://wiki.glidernet.org/receiver-naming-convention
  Call = "[OGN_CALLSIGN]"; # APRS callsign (max. 9 characters)
};
```

### Create OGN RF script

```sh
sudo nano /opt/rtlsdr-ogn/[OGN_CALLSIGN]"_rf
```

```content
#!/usr/bin/env bash

cd /opt/rtlsdr-ogn
sudo /opt/rtlsdr-ogn/ogn-rf /opt/rtlsdr-ogn/[OGN_CALLSIGN].conf
```

Make it executable

```sh
chmod +x /opt/rtlsdr-ogn/[OGN_CALLSIGN]_rf
```

### Create OGN Decode script

```sh
sudo nano /opt/rtlsdr-ogn/[OGN_CALLSIGN]"_decode
```

```content
#!/usr/bin/env bash

cd /opt/rtlsdr-ogn
/opt/rtlsdr-ogn/ogn-decode /opt/rtlsdr-ogn/[OGN_CALLSIGN].conf
```

Make it executable

```sh
chmod +x /opt/rtlsdr-ogn/[OGN_CALLSIGN]_decode
```

### Create OGN rf service

```sh
sudo nano /etc/systemd/system/ogn-[OGN_CALLSIGN]-rf.service
```

```content
[Unit]
Description=RF service for [OGN_CALLSIGN]

[Service]
User=ogn
RuntimeDirectory=ogn_[OGN_CALLSIGN]_rf
Type=simple
Restart=on-failure
RestartSec=30
SyslogIdentifier=ogn_[OGN_CALLSIGN]_rf
LimitCORE=infinity
ExecStart=/opt/rtlsdr-ogn/[OGN_CALLSIGN]_rf
Nice=5

[Install]
WantedBy=default.target
```

### Create OGN decode service

```sh
sudo nano /etc/systemd/system/ogn-[OGN_CALLSIGN]-decode.service
```

```content
[Unit]
Description=Decode service for [OGN_CALLSIGN]

[Service]
User=ogn
RuntimeDirectory=ogn_[OGN_CALLSIGN]_decode
Type=simple
Restart=on-failure
RestartSec=30
SyslogIdentifier=ogn_[OGN_CALLSIGN]_decode
LimitCORE=infinity
ExecStart=/opt/rtlsdr-ogn/[OGN_CALLSIGN]_decode
Nice=5

[Install]
WantedBy=default.target
```

### Put all OGN files under ogn user ownership

```sh
chown -R ogn:ogn /opt/rtlsdr-ogn
```

### Start OGN services

```sh
sudo systemctl enable ogn-[OGN_CALLSIGN]-rf
sudo systemctl enable ogn-[OGN_CALLSIGN]-decide
sudo systemctl start ogn-[OGN_CALLSIGN]-rf
sudo systemctl start ogn-[OGN_CALLSIGN]-decide
```

### See your call-sign on the :map:

Now open up the IP address of your pi with port 8081 in your browser

### optional when you have 2 usb sticks

#### Install dump1090-fa

#### Install FlightRadar24 feed

#### Setup FlightRadar24 service

### Raspberry Pi or similar with OS
