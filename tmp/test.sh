# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

e_header "Install Code Extensions"
code_packages=(
    christian-kohler.npm-intellisense
    dbaeumer.vscode-eslint
    EditorConfig.EditorConfig
    geeebe.duplicate
    mgmcdermott.vscode-language-babel
    ms-vscode.atom-keybindings
    PeterJausovec.vscode-docker
    robertohuertasm.vscode-icons
    Tyriar.sort-lines
    wmaurer.change-case
)
# for package in "${code_packages[@]}"; do
#     code --install-extension $package
# done

e_header "Copy VSCode Settings"
cp -r "$app_settings_path/code/" "$app_support_path/Code/User"
