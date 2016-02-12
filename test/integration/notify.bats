#!/usr/bin/env bats

load suite

@test 'notify should exit 0 and create notification' {
  skip-osx
  build/bin/circleci notify rockymadden/circleci-cli 1
}
