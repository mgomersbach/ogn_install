#!/usr/bin/env bats

load test_helper

setup() {
  ogn_install -n
}

@test "Created /etc/modprobe.d/blacklist-dvbt.conf" {
  skip
  [ -f /etc/modprobe.d/blacklist-dvbt.conf ]
}

@test "Installed OGN pkgs" {
  [ -L "/opt/rtlsdr-ogn" ]
}

@test "Created OGN fifo" {
  [ -p "/opt/rtlsdr-ogn/ogn-rf.fifo" ]
}

@test "Created GPU device node" {
  [ -c "/dev/gpu_dev" ]
}

@test "Created OGN config template" {
  [ -f /opt/rtlsdr-ogn/testcallsign.conf ]
}

@test "Created OGN rf script and is executable" {
  [ -x /opt/rtlsdr-ogn/testcallsign_rf ]
}

@test "Created OGN decode script and is executable" {
  [ -x /opt/rtlsdr-ogn/testcallsign_decode ]
}

@test "Created OGN rf cron and is executable" {
  [ -x /etc/cron.d/testcallsign_rf ]
}

@test "Created OGN decode cron and is executable" {
  [ -x /etc/cron.d/testcallsign_decode ]
}

@test "Created OGN rf log" {
  [ -f /var/log/ogn/rf.log ]
}

@test "Created OGN decode log" {
  [ -f /var/log/ogn/decode.log ]
}

@test "Installed dump1090-fa pkgs" {
  [[ $(command -v dump1090-fa) ]]
}

@test "Installed FlightRadar24 repo" {
  run command -v fr24feed
  [ "$status" -eq 0 ]
}

@test "Downloaded OGN tarball is absent" {
  [ ! -f /tmp/rtlsdr-ogn-bin-RPI-GPU-latest.tgz ]
}

@test "Downloaded piaware dpkg is absent" {
  [ ! -f /tmp/piaware-repository_3.5.1_all.deb ]
}
