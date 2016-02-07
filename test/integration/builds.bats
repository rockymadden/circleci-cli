#!/usr/bin/env bats

load suite

@test 'builds should should exit 0 and output filtered build numbers' {
  run build/bin/circleci builds rockymadden/circleci-cli --filter='.[] | .build_num'
  [ "${status}" -eq 0 ]
  [ "${#lines[@]}" -gt 1 ]
}
