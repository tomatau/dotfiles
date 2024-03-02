#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Paths...

export GOPATH="$HOME/Code/tomatao/go"
export PYENV_ROOT="$HOME/.pyenv"
export NPM_TOKEN="REPLACE-ME"
export PGUSER="postgres"

function add_to_path_if_exists() {
  local directory ="$1"

  if ! [ -d "$directory" ]; then
    return
  fi

  if ! [ ":$PATH:" == *":$directory:"* ]; then
    export PATH="$PATH:$directory"
  fi
}

function remove_from_path() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

add_to_path_if_exists("/usr/local/sbin")
add_to_path_if_exists("$GOPATH/bin")
add_to_path_if_exists("$HOME/.cargo/bin")
add_to_path_if_exists("$HOME/.bin")

export PATH

# Load Shell Scripts in order
for file in ~/.shell/{options,history,aliases_file,aliases_programs,osx,ubuntu,tweaks}.sh; do
  [ -r ${file} ] && source ${file}
done

unset file

# Programs...

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

if [ -x "$(command -v pyenv)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init bash)"
fi

if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

if [ -x "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_path="$(brew --prefix)/anaconda3";
__conda_setup="$($__conda_path/bin/conda 'shell.bash' 'hook' 2> /dev/null)";

if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$__conda_path/etc/profile.d/conda.sh" ]; then
        . "$__conda_path/etc/profile.d/conda.sh"
    else
        export PATH="$__conda_path/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
