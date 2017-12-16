set -x NPM_TOKEN

if test -d $HOME/.bin
    set PATH $HOME/.bin $PATH
end

set EDITOR 'subl'

alias g=git

# Show/hide hidden files in Finder
alias hiddenShow="defaults write com.apple.finder AppleShowAllFiles -bool true; and killall Finder"
alias hiddenHide="defaults write com.apple.finder AppleShowAllFiles -bool false; and killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# quick open
alias o=open

alias reload="exec $SHELL -l"
