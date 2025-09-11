#!/usr/bin/env bash

# We need GCC (XCode) and not a darwin OSS (linux-gnu is fine)
if [[ ! "$(type -P gcc)" && "$OSTYPE" =~ ^darwin ]]; then
  e_error "XCode or the Command Line Tools for XCode must be installed first."
  exit 1
fi

# GIT - Ubuntu only
if [[ ! "$(type -P git)" && "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
  e_header "Installing Git"
  sudo apt-get -qq install git
fi

if [[ ! "$(type -P git)" ]]; then
  e_error "Git should be installed. It isn't. Aborting."
  exit 1
fi
