#!/usr/bin/env bats

load test_helper

setup() {
  ogn_install -vn
}

@test "Created /etc/modprobe.d/blacklist-dvbt.conf"
{
  [ -f /etc/modprobe.d/blacklist-dvbt.conf ]
}

@test "Installed OGN pkgs"
{
  [ -L "/opt/rtlsdr-ogn" ]
}

@test "Created OGN fifo"
{
  [ -p "/opt/rtlsdr-ogn/ogn-rf.fifo" ]
}

@test "Created GPU device node"
{
  [ -c "/dev/gpu_dev" ]
}

@test "Created OGN config template"
{
  [ -f /opt/rtlsdr-ogn/testcallsign.conf ]
}
