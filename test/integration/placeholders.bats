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
