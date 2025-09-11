#!/bin/bash

alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

alias ls="lsd"
alias l='ls -lF'
alias ll='ls -lF --ignore-config'
alias la='ls -AlF'
alias laa='ls -AlF --ignore-config'
alias las='ls -AlFS'
alias lt='ls --tree -d'
alias lta='ls --tree --ignore-config'

# Create a new directory and enter it
function take() {
  mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
  find . -name "$1"
}
