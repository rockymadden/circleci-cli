#!/usr/bin/env bats

load suite

@test 'trigger should exit 0 and output filtered vcs revision' {
  run build/bin/circleci trigger rockymadden/circleci-cli master \
    --revision=634f9656ccf6e0cad7385782e776569bddbf84d6 \
    --filter='.vcs_revision'
  [ "${status}" -eq 0 ]
  [ "${output}" = '634f9656ccf6e0cad7385782e776569bddbf84d6' ]
}

@test 'trigger should exit 0 and output filtered build parameter' {
  run build/bin/circleci trigger rockymadden/circleci-cli master \
    --revision=634f9656ccf6e0cad7385782e776569bddbf84d6 \
    --parameter-key=key1 --parameter-value=val1 \
    --parameter-key=key2 --parameter-value=val2 \
    --filter='.build_parameters .key1'
  [ "${status}" -eq 0 ]
  [ "${output}" = 'val1' ]
}
