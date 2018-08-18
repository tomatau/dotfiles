# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

declare app_settings_path="$PARENT/app-settings"

declare atom_path="$HOME/.atom/"
cp "$app_settings_path/config.cson" "$atom_path"
cp "$app_settings_path/keymap.cson" "$atom_path"
cp "$app_settings_path/snippets.cson" "$atom_path"
