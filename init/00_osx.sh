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

    casks=(
        airflow
        android-file-transfer
        atom
        betterzip
        bitbar
        cd-to
        chromedriver
        cleanmymac
        dbeaver-community
        discord
        docker
        firefox-developer-edition
        franz
        google-backup-and-sync
        google-chrome
        grammarly
        iina
        iterm2
        java
        karabiner-elements
        lulu
        postman
        qbittorrent
        qlcolorcode
        qlimagesize
        qlmarkdown
        qlstephen
        qlvideo
        quicklook-json
        robo-3t
        sequel-pro
        shiftit
        skype
        slack
        sublime-text
        textmate
        the-unarchiver
        virtualbox
        visual-studio-code
        xquartz
        yed
        zoomus
    )

    cask_list="$(to_install "${casks[*]}" "$(brew cask list 2>/dev/null)")"
    if [[ "$cask_list" ]]; then
        e_header "Installing Homebrew casks: $cask_list"
        brew cask install $cask_list
    fi
    brew cask cleanup

    # Install Homebrew recipes.
    recipes=(
        ack
        bash
        bash-completion
        curl
        ffmpeg
        fish
        gh
        git
        gnutls
        heroku
        highlight
        imagemagick
        jq
        mongodb
        mysql
        nginx
        postgresql
        shellcheck
        sqlite
        ssh-copy-id
        tldr
        tree
        vim
        wget
    )

    recipe_list="$(to_install "${recipes[*]}" "$(brew list)")"
    if [[ "$recipe_list" ]]; then
        e_header "Installing Homebrew recipes: $recipe_list"
        brew install $recipe_list
    fi
    brew cleanup
    # This is where brew stores its binary symlinks
    local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

    # bash
    if [[ "$(type -P $binroot/bash)" && ! "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
        e_header "Adding $binroot/bash to the list of acceptable shells"
        echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
    fi

    # fish
    if [[ "$(type -P $binroot/fish)" && ! "$(cat /etc/shells | grep -q "$binroot/fish")" ]]; then
        e_header "Adding $binroot/fish to the list of acceptable shells"
        echo "$binroot/fish" | sudo tee -a /etc/shells >/dev/null
    fi

    if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
        e_header "Making $binroot/bash your default shell"
        sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
    fi
fi

if [[ "$(type -P fish)" ]]; then
    e_header "Install fisher plugins for fish!"
    fish -c fisher
fi

e_success "OSX specific install complete"
