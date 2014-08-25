#!/usr/bin/env bash

# when running scripts this is filename (nice)
SCRIPT=$(basename "$0")
# when running scripts this is dir (nice)
PWATH=$(dirname "${BASH_SOURCE[0]}")

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

#  TODO gitpull here!

source "$PWATH/dotfiles_functions.sh"
source "$PWATH/dotfiles_requirements.sh"
source "$PWATH/dotfiles_sync.sh"

cd ~/.bin

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