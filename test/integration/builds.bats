#!/usr/bin/env bats

load suite

@test 'builds should succeed' {
  run build/bin/circleci builds rockymadden/circleci-cli --filter='.[] | .build_num'
  [ ${status} -eq 0 ]
  [ "${#lines[@]}" -gt 1 ]
}

@test 'builds should succeed with shorthand project' {
  run build/bin/circleci builds -- --filter='.[] | .build_num'
  [ ${status} -eq 0 ]
  [ "${#lines[@]}" -gt 1 ]
}

@test 'builds should succeed with implicit project' {
  run build/bin/circleci builds --filter='.[] | .build_num'
  [ ${status} -eq 0 ]
  [ "${#lines[@]}" -gt 1 ]
}
