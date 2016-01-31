#!/usr/bin/env bats

load suite

@test 'retry should exit 0 and output filtered status' {
  run build/bin/circleci retry rockymadden/circleci-cli 1 --filter='.status'
  [ ${status} -eq 0 ]
  [ "${output}" = 'scheduled' ]
}
