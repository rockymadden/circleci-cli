#!/usr/bin/env bats

load suite

@test 'artifacts should exit 0 and output empty array' {
  run build/bin/circleci artifacts rockymadden/circleci-cli 1
  [ "${status}" -eq 0 ]
  [ "${output}" = '[]' ]
}
