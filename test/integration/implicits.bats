#!/usr/bin/env bats

load suite

@test 'implicit project and build should work with artifacts' {
  skip-hub
  run build/bin/circleci artifacts
  [ "${status}" -eq 0 ]
  [ "${output}" = '[]' ]
}

@test 'implicit project and branch should work with trigger' {
  skip-hub
  run build/bin/circleci trigger \
    --revision=634f9656ccf6e0cad7385782e776569bddbf84d6 \
    --filter='.vcs_revision'
  [ "${status}" -eq 0 ]
  [ "${output}" = '634f9656ccf6e0cad7385782e776569bddbf84d6' ]
}
