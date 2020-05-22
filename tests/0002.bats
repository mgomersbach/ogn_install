#!/usr/bin/env bats

load test_helper

@test "Create /etc/modprobe.d/blacklist-dvbt.conf" {
  run ogn_install -vn
  [ "$status" -eq 0 ]
  [ -f /etc/modprobe.d/blacklist-dvbt.conf ]
}
