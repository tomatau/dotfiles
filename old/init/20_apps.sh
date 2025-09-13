#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

# TextMate

e_header "Install TextMate Settings"

local textmate_bundles_path="$app_support_path/TextMate/Managed/Bundles/"
if ! [[ -d "$textmate_bundles_path" ]]; then
    mkdir -p $textmate_bundles_path
fi
git git@github.com:sanssecours/Fish.tmbundle.git
