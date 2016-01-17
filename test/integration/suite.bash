function setup() {
  if [ -z "${CIRCLECI_CLI_TOKEN}" ]; then
    skip "Environment variable not defined"
  fi
}
