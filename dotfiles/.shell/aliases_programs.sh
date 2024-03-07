#!/bin/bash

alias reload="exec $SHELL -l"
alias g="git"

export EDITOR='subl -w'
export PAGER='moar'
export GREP_OPTIONS='--color=auto'

alias brewupdate="brew update && brew upgrade && brew upgrade --cask && brew cleanup"

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'
# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

# Enable tab completion for `g` by marking it as an alias for `git`
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  complete -o default -o nospace \
    -F "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" \
    g;
fi;

# vim to allow Ctrl+S to save
function vim() {
  # Save current stty options.
  local STTYOPTS="$(stty -g)"

  # Disable intercepting of ctrl-s and ctrl-q as flow control.
  stty stop '' -ixoff -ixon

  # Execute vim.
  command vim "$@"

  # Restore saved stty options.
  stty "$STTYOPTS"
}

function ngrokserver() {
  local port="${1:-9000}";
  ngrok -subdomain=tomatao "${port}"
}

function setjdk() {
  remove_from_path `/usr/libexec/java_home`
  export JAVA_HOME=`/usr/libexec/java_home -v $@`
  export PATH=$JAVA_HOME/bin:$PATH
  java -version
}
