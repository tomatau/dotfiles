#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

e_header "Copying iTerm2 profiles"
cp "$app_settings_path/iTerm2.json" "$app_support_path/iTerm2/DynamicProfiles/"

e_header "Copying Sublime Text Package Settings"
declare st3_user_path="$app_support_path/Sublime Text 3/Packages/User/"
cp "$app_settings_path/Package Control.sublime-settings" "$st3_user_path"
cp "$app_settings_path/Preferences.sublime-settings" "$st3_user_path"
cp "$app_settings_path/Default (OSX).sublime-keymap" "$st3_user_path"
cp -r "$app_settings_path/JavaScript" "$st3_user_path/JavaScript/"

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

e_header "Copy Atom Settings"

declare atom_path="$HOME/.atom/"
cp "$app_settings_path/config.cson" "$atom_path"
cp "$app_settings_path/keymap.cson" "$atom_path"
cp "$app_settings_path/snippets.cson" "$atom_path"
cp "$app_settings_path/styles.less" "$atom_path"
