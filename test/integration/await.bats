#!/usr/bin/env bats

load suite

@test 'await should exit 0 and output filtered status' {
  run build/bin/circleci await rockymadden/circleci-cli 1 --filter='.status'
  [ "${status}" -eq 0 ]
  [ "${output}" = 'no_tests' ]
}
