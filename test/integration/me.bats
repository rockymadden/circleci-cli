#!/usr/bin/env bats

load suite

@test "me should succeed predictably" {
  run build/bin/circleci me --filter='.login'
  [ ${status} -eq 0 ]
  [ "${output}" = 'rockymadden' ]
}
