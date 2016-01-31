#!/usr/bin/env bats

load suite

@test 'projects should exit 0 and output filtered repo names' {
  run build/bin/circleci projects --filter='.[] | .username + "/" + .reponame'
  [ ${status} -eq 0 ]
  [ "${#lines[@]}" -gt 1 ]
}
