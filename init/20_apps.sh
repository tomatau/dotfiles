#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings="$PARENT/app-settings"
declare app_support="$HOME/Library/Application Support"

e_header "Copying iTerm2 profiles"
cp "$app_settings/iTerm2.json" "$app_support/iTerm2/DynamicProfiles/"

e_header "Copying Sublime Text Package Settings"
declare st3_user="$app_support/Sublime Text 3/Packages/User/"
cp "$app_settings/Package Control.sublime-settings" "$st3_user"
cp "$app_settings/Preferences.sublime-settings" "$st3_user"
cp "$app_settings/Default (OSX).sublime-keymap" "$st3_user"
cp -r "$app_settings/JavaScript" "$st3_user/JavaScript/"

e_header "Install Atom Packages"
packages=(
    advanced-open-file
    autocomplete-paths
    autocomplete-plus
    busy-signal # dep
    change-case
    duplicate-line-or-selection
    editorconfig
    emmet
    foldername-tabs
    highlight-selected
    hyperclick
    intentions # dep
    js-hyperclick
    jumpy
    language-babel
    language-docker
    language-fish-shell
    language-markdown
    linter # dep
    linter-eslint
    linter-jsonlint
    linter-retext
    linter-scss-lint
    linter-ui-default # dep
    pretty-json
    seti-ui
    sort-lines
    sublime-block-comment
)

apm install ${packages[*]}
