alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

alias ls="lsd"
alias l='ls -lF'
alias li='ls -lF --ignore-config'
alias la='ls -AlF'
alias lai='ls -AlF --ignore-config'
alias las='ls -AlFS'
alias lt='ls --tree -d'
alias lti='ls --tree --ignore-config'

# Create a new directory and enter it
function take() {
  mkdir -p "$@" && cd "$@"
}
