#!/usr/bin/env bats

load suite

@test 'artifacts should succeed' {
  run build/bin/circleci artifacts rockymadden/circleci-cli 1
  [ ${status} -eq 0 ]
  [ "${output}" = '[]' ]
}

@test 'artifacts should succeed with shorthand project and build' {
  run build/bin/circleci artifacts -- --
  [ ${status} -eq 0 ]
  [ "${output}" = '[]' ]
}

@test 'artifacts should succeed with implicit project and build' {
  run build/bin/circleci artifacts
  [ ${status} -eq 0 ]
  [ "${output}" = '[]' ]
}
