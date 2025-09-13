#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

# Sublime Text

e_header "Copying Sublime Text PackageControl"

local sublime_installed_packages="$app_support_path/Sublime Text/Installed Packages/"

if [[ ! -d "$sublime_installed_packages" ]]; then
    mkdir -p "$sublime_installed_packages"
fi
cp -r "$app_settings_path/subl/Installed Packages/" "$sublime_installed_packages"

e_header "Copying Sublime Text User Settings"

local sublime_user_packages="$app_support_path/Sublime Text/Packages/User/"

if [[ ! -d "$sublime_user_packages" ]]; then
    mkdir -p "$sublime_user_packages"
fi

cp -r "$app_settings_path/subl/User/" "$sublime_user_packages"


# TextMate

e_header "Install TextMate Settings"

local textmate_bundles_path="$app_support_path/TextMate/Managed/Bundles/"
if ! [[ -d "$textmate_bundles_path" ]]; then
    mkdir -p $textmate_bundles_path
fi
git git@github.com:sanssecours/Fish.tmbundle.git
