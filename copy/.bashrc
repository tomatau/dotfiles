#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load Shell Scripts in order
for file in ~/.shell/{options,history,aliases_file,aliases_programs,aliases_vcs,osx,ubuntu,tweaks,wizenoze,prompt}.sh; do
  [ -r ${file} ] && source ${file}
done

unset file
