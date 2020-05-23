#!/usr/bin/env bash

test_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$test_directory/..:$PATH"

# Workaround for Github Ubuntu test env
apt install libssl1.0-dev

d() {
  mkdir -p "${1}"
}

f() {
  mkdir -p "$(dirname "${1}")" && touch "${1}"
}
