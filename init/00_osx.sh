#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    e_header "Installing Homebrew"
    true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

if [[ "$(type -P brew)" ]]; then
    e_header "Updating Homebrew"
    brew doctor
    brew update
    # Install GNU `sed`, overwriting the built-in `sed`

    brew install wget --enable-iri
    brew install vim --override-system-vi
    brew install homebrew/dupes/grep
    brew install homebrew/dupes/screen
    # Install Homebrew recipes.
    recipes=(
        ack
        bash
        bash-completion
        brew-cask
        boot2docker
        cowsay
        curl
        docker
        elasticsearch
        git
        imagemagick
        maven
        mongodb
        mycli
        mysql
        postgresql
        pycli
        redis
        sqlite
        ssh-copy-id
        tomcat
        tree
    )

    list="$(to_install "${recipes[*]}" "$(brew list)")"
    if [[ "$list" ]]; then
        e_header "Installing Homebrew recipes: $list"
        brew install $list
    fi
    brew cleanup
    # This is where brew stores its binary symlinks
    local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

    # bash
    if [[ "$( type -P $binroot/bash)" && ! "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
        e_header "Adding $binroot/bash to the list of acceptable shells"
        echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
    fi
    if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
        e_header "Making $binroot/bash your default sheman ll"
        sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
    fi

    casks=(
        asepsis
        cd-to
        cleanmymac2
        divvy
        firefox
        firefoxdeveloperedition
        # flux
        google-chrome
        google-chrome-canary
        heroku-toolbelt
        iterm2
        karabinder
        lastpass
        lunchy
        macdown
        mysqlworkbench
        opera
        rdm
        sequel-pro
        skype
        slack
        sublime-text3
        textmate
        the-unarchiver
        utorrent
        virtualbox
        vlc
    )

    brew tap caskroom/versions
    # Hack to show the first-run brew-cask password prompt immediately.
    brew cask info this-is-somewhat-annoying 2>/dev/null

    cask_list="$(to_install "${casks[*]}" "$(brew cask list 2>/dev/null)")"
    if [[ "$list" ]]; then
        e_header "Installing Homebrew casks: $cask_list"
        brew cask install $cask_list
    fi
    brew cask cleanup

    ln -s "/opt/homebrew-cask/Caskroom/google-chrome/latest/Google Chrome.app/Contents/MacOS/Google\ Chrome" "/Users/tomatao/.bin/google-chome"
fi

e_success "OSX specific install complete"