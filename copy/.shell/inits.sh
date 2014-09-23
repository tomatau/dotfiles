#!/bin/bash

[[ -s ~/.bin/z/z.sh ]] && . ~/.bin/z/z.sh

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

PHPBREW_SET_PROMPT=1
[[ -s ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc