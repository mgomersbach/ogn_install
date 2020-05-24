#!/usr/bin/env bash

test_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$test_directory/..:$PATH"
IS_SYSTEMD=$(if [ -d /run/systemd/system ]; then echo "true"; fi)
export IS_SYSTEMD

d() {
  mkdir -p "${1}"
}

f() {
  mkdir -p "$(dirname "${1}")" && touch "${1}"
}
