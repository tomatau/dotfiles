#!/usr/bin/env bash

PYENV_ROOT="$HOME/.pyenv"
# python_installs=(
#   pip
# )

# python_eggs=(
#   nose
# )

# export NOSE_REDNOSE=1
e_header "Installing Pyenv"

if [[ ! "$(type -P pyenv)" ]]; then
  git clone git://github.com/yyuu/pyenv.git "$PYENV_ROOT"
  # TODO: add check here
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  git clone https://github.com/yyuu/pyenv-pip-rehash.git \
    "$PYENV_ROOT"/plugins/pyenv-pip-rehash
  e_success "Installed Pyenv"
else
  e_header "Pyenv already installed :)"
fi

e_header "Installing Python"

# TODO: iterate over versions with checks
if [[ "$(type -P pyenv)" ]]; then
  pyenv install 2.7.6
  pyenv install 3.4.1
  pyenv global 2.7.6
  pyenv rehash
else
  e_error "Pyenv was not installed correctly :/"
fi

# TODO: iterate over any eggs or something
