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

```
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
tar xvzf /tmp/rtlsdr-ogn-bin.tgz -C /opt
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

Replace [YOURCALLSIGN] with... your callsign.

```sh
sudo nano /opt/rtlsdr-ogn/[YOURCALLSIGN].conf
```

### Create OGN RF script

### Create OGN Decode script

### Create OGN rf service

### Create OGN decode service

### optional when you have 2 usb sticks

#### Install dump1090-fa

#### Install FlightRadar24 feed

#### Setup FlightRadar24 service

### Raspberry Pi or similar with OS
