#!/usr/bin/env bats

load suite

@test 'build should succeed' {
  run build/bin/circleci build rockymadden/circleci-cli 1 --filter='.build_num'
  [ ${status} -eq 0 ]
  [ "${output}" = '1' ]
}

@test 'build should succeed with shorthand project and build' {
  run build/bin/circleci build -- -- --filter='.build_num'
  [ ${status} -eq 0 ]
  [ "${output}" -gt 1 ]
}

@test 'build should succeed with implicit project and build' {
  run build/bin/circleci build --filter='.build_num'
  [ ${status} -eq 0 ]
  [ "${output}" -gt 1 ]
}
