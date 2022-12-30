#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"
# export NPM_TOKEN="ADD_NPM_TOKEN_HERE"

# Load Shell Scripts in order
for file in ~/.shell/{options,history,aliases_file,aliases_programs,aliases_vcs,osx,ubuntu,tweaks,prompt}.sh; do
  [ -r ${file} ] && source ${file}
done

unset file

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
