#!/usr/bin/env bats

load suite

@test "init should succeed predictably" {
  build/bin/circleci init --token=${CIRCLECI_CLI_TOKEN}
}
