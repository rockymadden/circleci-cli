#!/usr/bin/env bats

load suite

@test 'project should should exit 0 and output filtered repo name' {
  run build/bin/circleci project rockymadden/circleci-cli --filter='.username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden/circleci-cli' ]
}
