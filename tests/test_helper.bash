#!/usr/bin/env bash

test_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$test_directory/..:$PATH"

# Add apt sources
sudo apt-get update && sudo apt-get install -y apt-transport-https

d() {
  mkdir -p "${1}"
}

f() {
  mkdir -p "$(dirname "${1}")" && touch "${1}"
}
