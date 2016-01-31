#!/usr/bin/env bats

load suite

@test 'await should succeed' {
  run build/bin/circleci await rockymadden/circleci-cli 1 --filter='.status'
  [ ${status} -eq 0 ]
  [ "${output}" = 'no_tests' ]
}

@test 'await should succeed with shorthand project and build' {
  run build/bin/circleci await -- -- --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}

@test 'await should succeed with implicit project and build' {
  run build/bin/circleci await --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}
