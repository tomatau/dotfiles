set -g fish_prompt_pwd_dir_length 2
set -Ux LSCOLORS fxefcxdxbxexexabagacad

set -x NPM_TOKEN "tmp-123-abc"

set -x NVM_DIR "$HOME/.nvm"

set -x PGUSER "postgres"

set PATH "/usr/local/bin" "/opt/X11/bin" "/usr/local/sbin" $PATH

if test -d "$HOME/.bin"
    set PATH "$HOME/.bin" $PATH
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

alias reload="exec "(which fish)" -l"

# brew
alias brewupdate="brew update; and brew upgrade; and brew cask upgrade; and brew cleanup"

# docker
alias dockerkillall='docker kill (docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n"; and docker rm (docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n"; and docker rmi (docker images -q -f dangling=true)'
alias dockerclean='dockercleanc; or true; and dockercleani'
