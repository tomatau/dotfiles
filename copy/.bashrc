#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load Shell Scripts

# ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
# for file in ./copy/.shell/{extra,prompt,exports,aliases,functions}; do
#   [ -r ${file} ] && . ${file}
# done

for file in ./.shell/*; do
  . "$file"
done

unset file

