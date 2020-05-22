#!/usr/bin/env bats

load test_helper

@test "print help and exit with 1 on -h argument" {
  run ogn_install -h
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage:" ]
}

@test "print help and exit with 1 on no argument" {
  run ogn_install
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "Usage:" ]
}
