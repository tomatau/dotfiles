#!/bin/bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ];
    then source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ];
    then source /etc/bash_completion;
fi;

# Show/hide hidden files in Finder
alias hiddenShow="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hiddenHide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# quick open
alias o=open
