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

    brew install wget --enable-iri
    brew install vim --override-system-vi
    brew tap homebrew/cask

    brew install cask

    casks=(
        airflow
        android-file-transfer
        atom
        bitbar
        cd-to
        chromedriver
        cleanmymac
        dbeaver-community
        discord
        docker
        firefox
        firefox-developer-edition
        franz
        google-chrome
        google-backup-and-sync
        iina
        iterm2
        java
        karabiner-elements
        lulu
        now
        postman
        qbittorrent
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
    )

    brew tap caskroom/versions

    cask_list="$(to_install "${casks[*]}" "$(brew cask list 2>/dev/null)")"
    if [[ "$cask_list" ]]; then
        e_header "Installing Homebrew casks: $cask_list"
        brew cask install $cask_list
    fi
    brew cask cleanup

    # ln -s "/opt/homebrew-cask/Caskroom/google-chrome/latest/Google Chrome.app/Contents/MacOS/Google\ Chrome" "/Users/tomatao/.bin/google-chome"

    # Install Homebrew recipes.
    recipes=(
        ack
        bash
        bash-completion
        curl
        ffmpeg
        fish
        git
        heroku
        highlight
        imagemagick
        jq
        mongodb
        mycli
        mysql
        nginx
        pgcli
        postgresql
        sqlite
        ssh-copy-id
        tldr
        tree
        vim
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
    if [[ "$( type -P $binroot/bash)" && ! "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
        e_header "Adding $binroot/bash to the list of acceptable shells"
        echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
    fi
    if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
        e_header "Making $binroot/bash your default sheman ll"
        sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
    fi
fi

if [[ "$(type -P fish)" ]]; then
    e_header "Install fisher plugins for fish!"
    fish -c fisher
fi

e_success "OSX specific install complete"
