#!/usr/bin/env bats

load suite

function setup() {
  if [ "$(uname -s)" != 'Darwin' ]; then
    skip 'OS X should be available'
  fi
}

@test 'browse should exit 0 and open browser' {
  build/bin/circleci browse rockymadden/circleci-cli 1
}
