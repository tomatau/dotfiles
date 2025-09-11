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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bash_profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && exit 1

if [[ "$(type -P brew)" ]]; then
    e_header "Updating Homebrew"
    brew doctor
    brew update
    brew tap homebrew/cask-fonts

    cask_dependencies=(
        xquartz
        docker
    )

    casks=(
        airflow
        anaconda
        android-file-transfer
        brave-browser
        chromedriver
        cleanmymac
        cog
        discord
        firefox
        folx
        font-3270-nerd-font
        font-monofur-nerd-font
        font-overpass-nerd-font
        font-ubuntu-mono-nerd-font
        google-chrome
        google-cloud-sdk
        grammarly
        iina
        iterm2
        kap
        karabiner-elements
        lastpass
        lm-studio
        messenger
        ngrok
        nordvpn
        obsidian
        ollamac
        openinterminal
        postman
        qlcolorcode
        qlimagesize
        qlmarkdown
        qlstephen
        qlvideo
        quicklook-json
        raycast
        slack
        soulseek
        spotify
        sublime-text
        syntax-highlight
        textmate
        the-unarchiver
        thunderbird
        visual-studio-code
        warp
        whatsapp
        zed
        zoom
    )

    cask_list_deps="$(to_install "${cask_dependencies[*]}" "$(brew list --cask 2>/dev/null)")"
    if [[ "$cask_list_deps" ]]; then
        e_header "Installing dependency casks"
        e_header "casks = $cask_list_deps"
        brew install --cask $cask_list_deps
    fi

    # Install Homebrew recipes.
    recipe_dependencies=(
        ack
        bash
        curl
        git
        gnutls
        # java
        proto
        rustup-init
        vim
        wget
        zsh
    )

    recipes=(
        awscli
        bash-completion
        bat
        bpython
        difftastic
        direnv
        ffmpeg
        fish
        fnm
        fzf
        gh
        git-delta
        helm
        highlight
        imagemagick
        iredis
        jq
        k9s
        kubernetes-cli
        lastpass-cli
        lsd
        minikube
        moar
        nushell
        ollama
        poetry
        pulumi
        pyenv
        pyenv-virtualenv
        rawdog
        redis
        snyk
        sqlite
        ssh-copy-id
        starship
        terraform
        tldr
        zoxide
        zsh
        zsh-autosuggestions
    )

    recipe_list_deps="$(to_install "${recipe_dependencies[*]}" "$(brew list)")"
    if [[ "$recipe_list_deps" ]]; then
        e_header "Installing dependency recipes"
        e_header "recipes = $recipe_list_deps"
        brew install $recipe_list_deps
    fi

    e_header "Installing rust..."
    rustup-init -y

    cask_list="$(to_install "${casks[*]}" "$(brew list --cask 2>/dev/null)")"
    if [[ "$cask_list" ]]; then
        e_header "Installing remaining casks"
        e_header "casks = $cask_list"
        brew install --cask $cask_list
    fi

    recipe_list="$(to_install "${recipes[*]}" "$(brew list)")"
    if [[ "$recipe_list" ]]; then
        e_header "Installing remaining recipes"
        e_header "recipes = $recipe_list"
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

    # zsh
    if [[ "$(type -P $binroot/zsh)" && ! "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
        e_header "Adding $binroot/zsh to the list of acceptable shells"
        echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
    fi

    # fish
    if [[ "$(type -P $binroot/fish)" && ! "$(cat /etc/shells | grep -q "$binroot/fish")" ]]; then
        e_header "Adding $binroot/fish to the list of acceptable shells"
        echo "$binroot/fish" | sudo tee -a /etc/shells >/dev/null
    fi

    # updating default zsh
    if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
        e_header "Making upgraded $binroot/zsh your default shell"
        sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
    fi
fi

# Create my directories yo
if [[ ! -d "$HOME/Code" ]]; then
    mkdir $HOME/Code
fi

# Need to be in fish shell to install terminal
# if [[ "$(type -P fish)" ]]; then
#     e_header "Install fisher plugins for fish!"
#     curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
#         | source && fisher install jorgebucaran/fisher
# fi

e_success "OSX specific install complete"
