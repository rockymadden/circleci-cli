#!/usr/bin/env bats

load suite

@test 'cancel should succeed' {
  run bash -c "build/bin/circleci retry rockymadden/circleci-cli 1 --filter='.build_num' | xargs -I{} build/bin/circleci cancel rockymadden/circleci-cli '{}' --filter='.status'"
  [ ${status} -eq 0 ]
  [ "${output}" = 'canceled' ]
}
