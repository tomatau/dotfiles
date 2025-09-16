#!/usr/bin/env bash

set-strict-mode() {
  # exit immediately on non-zero exit code
  set -e
  # no silent errors
  set -u
  # don't mask errors in pipeline
  set -o pipefail
  # print executed commands
  # set -x
}

p-header() {
  local color="$1"
  local message="$2"
  case "$color" in
    "red") printf "\n\e[31m%s\n\e[0m" "$message" ;;
    "green") printf "\n\e[32m%s\n\e[0m" "$message" ;;
    "purple") printf "\n\e[35m%s\n\e[0m" "$message" ;;
    "amber") printf "\n\e[33m%s\n\e[0m" "$message" ;;
    "blue") printf "\n\e[34m%s\n\e[0m" "$message" ;;
    "white") printf "\n\e[37m%s\n\e[0m" "$message" ;;
    *) printf "\n%s\n" "$message" ;;
  esac
}
