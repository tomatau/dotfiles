#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

e_header "Copying iTerm2 profiles"
cp "$app_settings_path/iTerm2.json" "$app_support_path/iTerm2/DynamicProfiles/"

e_header "Copying Sublime Text Package Settings"
cp -r "$app_settings_path/subl/" "$app_support_path/Sublime Text 3/Packages/User/"

e_header "Install Atom Packages"
atom_packages=(
    advanced-open-file
    autocomplete-paths
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
    linter-sass-lint
    linter-ui-default # dep
    pretty-json
    seti-ui
    sort-lines
    sublime-block-comment
    svg-preview
)
apm install ${atom_packages[*]}

e_header "Copy Atom Settings"
cp -r "$app_settings_path/atom/" "$HOME/.atom/"

e_header "Install Code Extensions"
code_packages=(
    asvetliakov.snapshot-tools
    christian-kohler.npm-intellisense
    christian-kohler.path-intellisense
    cssho.vscode-svgviewer
    dbaeumer.vscode-eslint
    dunstontc.viml
    EditorConfig.EditorConfig
    Equinusocio.vsc-material-theme
    ExodiusStudios.comment-anchors
    geeebe.duplicate
    lunaryorn.fish-ide
    mgmcdermott.vscode-language-babel
    mikestead.dotenv
    ms-vscode.atom-keybindings
    Orta.vscode-jest
    PeterJausovec.vscode-docker
    ritwickdey.LiveServer
    sidneys1.gitconfig
    skyapps.fish-vscode
    sleistner.vscode-fileutils
    streetsidesoftware.code-spell-checker
    techer.open-in-browser
    travisthetechie.write-good-linter
    Tyriar.sort-lines
    vscode-icons-team.vscode-icons
    wmaurer.change-case
    yzhang.markdown-all-in-one
)
for package in "${code_packages[@]}"; do
    code --install-extension $package
done

e_header "Copy VSCode Settings"
cp -r "$app_settings_path/code/" "$app_support_path/Code/User"
