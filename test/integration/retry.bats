#!/usr/bin/env bats

load suite

@test 'retry should succeed' {
  run build/bin/circleci retry rockymadden/circleci-cli 1 --filter='.status'
  [ ${status} -eq 0 ]
  [ "${output}" = 'scheduled' ]
}
