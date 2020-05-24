#!/usr/bin/env bats

load test_helper

setup() {
  ogn_install -n
}

@test "Created DVBT blacklist" {
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

@test "Created OGN RF service" {
  if [ "$IS_SYSTEMD" == "true" ]; then
    run systemctl is-enabled ogn_testcallsign_rf
    [ "$status" -eq 0 ]
  else
    [ -x /etc/cron.d/ogn_testcallsign_rf ]
  fi
}

@test "Created OGN decode service" {
  if [ "$IS_SYSTEMD" == "true" ]; then
    run systemctl is-enabled ogn_testcallsign_decode
    [ "$status" -eq 0 ]
  else
    [ -x /etc/cron.d/testcallsign_decode ]
  fi
}

@test "Created OGN rf log" {
  if [ "$IS_SYSTEMD" == "true" ]; then
    skip
  else
    [ -f /var/log/ogn_testcallsign_rf.log ]
  fi
}

@test "Created OGN decode log" {
  if [ "$IS_SYSTEMD" == "true" ]; then
    skip
  else
    [ -f /var/log/ogn_testcallsign_decode.log ]
  fi
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
