#!/usr/bin/env bash

function skip-env() {
  if [ -z "${CIRCLECI_CLI_TOKEN}" ]; then skip 'Environment variable should be available'; fi
}

function skip-hub() {
  if [ -z "$(which hub)" ]; then skip 'Hub should be available'; fi
}

function skip-osx() {
  if [ "$(uname -s)" != 'Darwin' ]; then skip 'OS X should be available'; fi
}

function setup() {
  skip-env
  echo "${CIRCLECI_CLI_TOKEN}" | build/bin/circleci init
}
