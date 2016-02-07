#!/usr/bin/env bats

load suite

@test 'build should exit 0 and output filtered build number' {
  run build/bin/circleci build rockymadden/circleci-cli 1 --filter='.build_num'
  [ "${status}" -eq 0 ]
  [ "${output}" = '1' ]
}
