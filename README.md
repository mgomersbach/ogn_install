# :radio: RTL-SDR installer for gliders

[![Radio](docs/radio_wireless_tower.png)](https://github.com/degozc/ogn_install)
> Radio not included

![Code Lint](https://github.com/mgomersbach/ogn_install/workflows/codelint/badge.svg) ![Commit Lint](https://github.com/mgomersbach/ogn_install/workflows/Commitlint/badge.svg)

As there are plenty manuals and scripts out there for any ADS-B setup, there are not many that combine OGN and dump1090.
Tries to accommodate as many environment and setups common to gliders with least amount of dependencies.

## :airplane: Installation

When the Raspberry Pi (or whatever) is installed with your Debian flavor (Raspbian), for now you see the following instructions, until I've finished the interactive part of the installer.

- Create a file "ognvars.sh" with nano (or whatever floats yar boat)

```sh
nano ognvars.sh
```

```sh
OGN_CALLSIGN=""
OGN_FREQCORR=""
OGN_GSMCENTERFREQ=""
OGN_GSMGAIN=""
OGN_LATITUDE=""
OGN_LONGITUDE=""
OGN_ALTITUDE=""
OGN_GEOIDSEPAR=""
```

- With the variables set to:

OGN_CALLSIGN:

  Station name: up to 9 characters
  See http://wiki.glidernet.org/receiver-naming-convention

OGN_LATITUDE OGN_LONGITUDE OGN_GEOIDSEPAR OGN_FREQCORR OGN_GSMCENTERFREQ OGN_GSMGAIN:

  Station coordinates, frequency offset and GSM parameters
  See http://wiki.glidernet.org/wiki:raspberry-pi-installation

- Start automated installer:

  Source the variables and begin the installation:

```sh
source ognvars.sh
curl -qs https://raw.githubusercontent.com/mgomersbach/ogn_install/master/ogn_install -o ogn_install && sudo bash ogn_install -i
```

This should give a you a installed OGN setup.

## :sob: If you have only one USB stick

Remember to disable dump1090 and fr24feed if not using a cron for glider condition constraints.

```sh
systemctl stop dump1090-fa
systemctl disable dump1090-fa
systemctl stop fr24feed
systemctl disable fr24feed
killall fr24feed
```

## :clipboard: Feature / Compatibility grid

| OS :penguin: | Status |
| --- | --- |
| Raspbian | :beers: |
| Ubuntu | :beer: |
| Gentoo | :baby_bottle: |

| Dongle/Chip | Status |
| --- | --- |
| Realtek RTL2838 | :beers: |
| Others | :baby_bottle: |

| Feed | Status |
| --- | --- |
| FlightRadar24 | :beers: |
| OGN | :beers: |
| FlightAware | :baby_bottle: |
| Plane Finder | :baby_bottle: |
| ADS-B Exchange | :baby_bottle: |

Mark Gomersbach – markgomersbach@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.
