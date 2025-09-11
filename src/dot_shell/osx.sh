# abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Show/hide hidden files in Finder
alias hiddenShow="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hiddenHide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# quick open
alias o=open
