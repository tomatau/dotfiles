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

# Install a proto tool at its globally pinned version, or latest if unpinned.
# A bare `proto install <tool>` always installs latest, which leaves the shim
# resolving to a pinned version that was never installed.
proto-install() {
  local tool="$1"
  local pinned
  pinned=$(sed -n "s/^${tool} = \"\(.*\)\"$/\1/p" "$HOME/.proto/.prototools" 2>/dev/null || true)
  proto install "$tool" ${pinned:+"$pinned"}
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
