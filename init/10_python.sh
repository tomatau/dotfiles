#!/usr/bin/env bash

PYENV_ROOT="$HOME/.pyenv"

declare default_python=2.7.6
declare python_versions=(
  "$default_python"
  3.4.1
  anaconda-2.1.0
)

function get_python_versions() {
  local installed=()
  for path in "$HOME/.pyenv/versions/"*; do
    if [ -d "$path" ]; then
      installed=("${installed[@]}" "${path##*/}")
    fi
  done
  echo "${installed[*]}"
}

# export NOSE_REDNOSE=1
e_header "Installing Pyenv"
if [[ ! "$(type -P pyenv)" ]]; then
  git clone git://github.com/yyuu/pyenv.git "$PYENV_ROOT"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  git clone https://github.com/yyuu/pyenv-pip-rehash.git \
    "$PYENV_ROOT"/plugins/pyenv-pip-rehash
  e_success "Installed Pyenv"
else
  e_header "Pyenv already installed :)"
fi

e_header "Installing Python"
if [[ "$(type -P pyenv)" ]]; then
  for v in $(to_install "${python_versions[*]}" "$(get_python_versions)"); do
    pyenv install "$v"
  done
  pyenv global "$default_python"
  pyenv rehash
  e_success "Python $default_python has been installed and set to default :)"
else
  e_error "Pyenv was not installed correctly :/"
  return 1
fi

e_success "Pyenv and Python setup :)"
# TODO: iterate over any eggs or something
