#!/usr/bin/env bash

# when running scripts this is filename (nice)
SCRIPT=$( basename "$0" )
# PWATH PATH
PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

echo "DOTFILES! - Let's Rock It!"

# If this is used with -h or --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $SCRIPT

This file will install tomatao's .bashrc

No options necessary.

Usage: bash or sh $SCRIPT

Please run in own shell, do not source

It will copy the bin directory into ~/.bin
It will run the scripts in the following directories:
- init

It will then do nothing :D DOTFILES!!!
HELP
exit; 
fi

#  TODO gitpull here for remote repo so we're up to date!?!
# but what if this file changes

source "$PWATH/dotfiles_functions.sh"
source "$PWATH/dotfiles_requirements.sh"
source "$PWATH/dotfiles_sync.sh"

cd $PARENT

# Add binaries to path
PATH=~/.bin:$PATH
export PATH


# Tweak file globbing.
shopt -s dotglob
shopt -s nullglob # make * eval to nothing if no files

# Run the installtion scripts in the following
e_header "Initializing!"
run_directory "init"


# . ~/.profile

e_header "All done!"