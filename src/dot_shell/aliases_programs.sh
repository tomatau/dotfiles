alias reload="exec $SHELL -l"
alias g="git"

alias brewupdate="brew update && brew upgrade && brew upgrade --cask && brew cleanup"

# kill all running containers
alias dockerkillall='docker kill $(docker ps -q)'
# delete all stopped containers
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# delete all untagged images
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# delete all stopped containers and untagged images
alias dockerclean='dockercleanc || true && dockercleani'

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
