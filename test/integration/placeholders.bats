#!/usr/bin/env bats

load suite

function setup() {
  if [ -z "$(which hub)" ]; then
    skip 'Hub should be available'
  fi
}

@test 'placeheld project and build should work with artifacts' {
  run build/bin/circleci artifacts -- --
  [ "${status}" -eq 0 ]
  [ "${output}" = '[]' ]
}

@test 'placeheld project and branch should work with trigger' {
  run build/bin/circleci trigger -- -- \
    --revision=634f9656ccf6e0cad7385782e776569bddbf84d6 \
    --filter='.vcs_revision'
  [ "${status}" -eq 0 ]
  [ "${output}" = '634f9656ccf6e0cad7385782e776569bddbf84d6' ]
}
