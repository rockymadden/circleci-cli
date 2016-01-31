#!/usr/bin/env bash

function setup() {
  if [ -z "${CIRCLECI_CLI_TOKEN}" ]; then
    skip 'Environment variable should exist'
  fi

  sleep 10 # Poor man's throttle
  build/bin/circleci init --token="${CIRCLECI_CLI_TOKEN}"
}
