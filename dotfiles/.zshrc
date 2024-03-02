export GOPATH="$HOME/Code/tomatao/go"
export PYENV_ROOT="$HOME/.pyenv"
export NPM_TOKEN="REPLACE-ME"
export PGUSER="postgres"
export EDITOR='subl -w'

function add_to_path_if_exists() {
  local dir="$1"
  local colon_path="${PATH//:/:}"
  colon_path="${colon_path// //}"

  if ! [ -d "$dir" ]; then
    return
  fi

  if ! [[ $colon_path == *":$dir:"* ]]; then
    export PATH="$PATH:$dir"
  fi
}

function remove_from_path() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

add_to_path_if_exists "$GOPATH/bin"
add_to_path_if_exists "$HOME/.cargo/bin"
add_to_path_if_exists "$HOME/.bin"

export PATH

alias o=open
alias reload="exec $SHELL -l"
alias g="git"

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

alias brewupdate="brew update && brew upgrade && brew upgrade --cask && brew cleanup"

alias hiddenShow="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hiddenHide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'
# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

function take() {
  mkdir -p "$@" && cd "$@"
}

function f() {
  find . -name "$1"
}

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

if [ -x "$(command -v pyenv)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
fi

if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

if [ -x "$(command -v starship)" ]; then
  eval "$(starship init zsh)"
fi

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

# Enable tab completion for `g` by marking it as an alias for `git`
if which brew > /dev/null && [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # complete -o default -o nospace \
  #   -F "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" \
  #   g;
fi;


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
