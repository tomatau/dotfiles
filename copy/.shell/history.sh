#!/bin/bash

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# To internity!...
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="[%F %T] "

# Easily re-execute the last history command.
# alias r="fc -s"

# Make some commands not show up in history
export HISTIGNORE="ls:l:ll:cd:cd -:pwd:exit:date:* --help";
