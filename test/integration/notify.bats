#!/usr/bin/env bats

load suite

function setup() {
  if [ "$(uname -s)" != 'Darwin' ]; then
    skip 'OS X should be available'
  fi
}

@test 'notify should succeed' {
  build/bin/circleci notify rockymadden/circleci-cli 1
}

@test 'notify should succeed with shorthand project and build' {
  build/bin/circleci notify -- --
}

@test 'notify should succeed with implicit project and build' {
  build/bin/circleci notify
}
