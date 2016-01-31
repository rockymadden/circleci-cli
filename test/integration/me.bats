#!/usr/bin/env bats

load suite

@test 'me should should exit 0 and output filtered login' {
  run build/bin/circleci me --filter='.login'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden' ]
}
