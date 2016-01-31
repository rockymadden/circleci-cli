#!/usr/bin/env bats

load suite

@test 'project should succeed' {
  run build/bin/circleci project rockymadden/circleci-cli --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}

@test 'project should succeed with shorthand project' {
  run build/bin/circleci project -- --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}

@test 'project should succeed with implicit project' {
  run build/bin/circleci project -- --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}
