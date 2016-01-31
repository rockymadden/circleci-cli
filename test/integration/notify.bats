#!/usr/bin/env bats

load suite

function setup() {
  if [ "$(uname -s)" != 'Darwin' ]; then
    skip 'OS X should be available'
  fi
}

@test 'notify should exit 0 and create notification' {
  build/bin/circleci notify rockymadden/circleci-cli 1
}
