# :radio: RTL-SDR installer for gliders

[![Radio](docs/radio_wireless_tower.png)](https://github.com/degozc/ogn_install)
> Radio not included

![Code Lint](https://github.com/mgomersbach/ogn_install/workflows/codelint/badge.svg) ![Commit Lint](https://github.com/mgomersbach/ogn_install/workflows/Commitlint/badge.svg)

As there are plenty manuals and scripts out there for any ADS-B setup, there are not many that combine OGN and dump1090.
Tries to accommodate as many environment and setups common to gliders with least amount of dependencies.

## :airplane: Installation

When the Raspberry Pi (or whatever) is installed with your Debian flavor (Raspbian):

```sh
curl -qs https://raw.githubusercontent.com/mgomersbach/ogn_install/master/ogn_install -o ogn_install && sudo bash ogn_install -i
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
| FlightAware | :beer: |
| Plane Finder | :baby_bottle: |
| ADS-B Exchange | :baby_bottle: |

Mark Gomersbach – markgomersbach@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.
