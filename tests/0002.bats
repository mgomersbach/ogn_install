#!/usr/bin/env bats

load test_helper

@test "Create /etc/modprobe/blacklist-dvbt.conf" {
  run ogn_install -v
  [ "$status" -eq 0 ]
  [ -f /etc/modprobe/blacklist-dvbt.conf ]
}
