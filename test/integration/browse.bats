#!/usr/bin/env bats

load suite

function setup() {
  if [ -n "$(uname -s)" != 'Darwin' ]; then
    skip 'OS X should be available'
  fi
}

@test 'browse should succeed' {
  build/bin/circleci browse rockymadden/circleci-cli 1
}

@test 'browse should succeed with shorthand project and build' {
  build/bin/circleci browse -- --
}

@test 'browse should succeed with implicit project and build' {
  build/bin/circleci browse
}
