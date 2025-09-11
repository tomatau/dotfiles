#!/usr/bin/env zsh

# custom word boundaries
# Define word boundaries to include . and - as separators
# WORDCHARS=${WORDCHARS//[.-]/}
# only a-Z and 0-9 are considered "words"
WORDCHARS=''

# Bind Option+LeftArrow and Option+Backspace for word navigation
bindkey "^[b" backward-word
bindkey "^[f" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[3~" backward-kill-word
