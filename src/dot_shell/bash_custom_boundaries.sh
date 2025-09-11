#!/usr/bin/env bash

# custom word boundaries
# Bind Option+LeftArrow and Option+Backspace for word navigation
bind '"\eb": backward-word'
bind '"\ef": forward-word'
bind '"\e[3~": backward-kill-word'
