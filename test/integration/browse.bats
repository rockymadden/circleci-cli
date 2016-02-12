#!/usr/bin/env bats

load suite

@test 'browse should exit 0 and open browser' {
  skip-osx
  build/bin/circleci browse rockymadden/circleci-cli 1
}
