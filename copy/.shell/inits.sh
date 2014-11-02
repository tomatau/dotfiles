#!/bin/bash

PATH="$HOME/.rbenv/bin:$PATH"

PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
# PATH=/usr/local/bin:$(path_remove /usr/local/bin)

# node
# export NODE_PATH='/usr/local/lib/node_modules'
# export PATH="usr/local/lib/node_modules:$PATH"

# ruby
# export RBENV_ROOT=/usr/local/var/rbenv

export PATH

[[ -s ~/.bin/z/z.sh ]] && . ~/.bin/z/z.sh

if which rbenv > /dev/null ; then
  eval "$(rbenv init -)";
fi

if which pyenv > /dev/null ; then
  eval "$(rbenv init -)";
fi

PHPBREW_SET_PROMPT=1
[[ -s ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc