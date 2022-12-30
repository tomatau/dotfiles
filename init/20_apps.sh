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
    file-icons
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
    # CoenraadS.bracket-pair-colorizer-2
    cssho.vscode-svgviewer
    dbaeumer.vscode-eslint
    dunstontc.viml
    EditorConfig.EditorConfig
    Equinusocio.vsc-community-material-theme
    Equinusocio.vsc-material-theme
    equinusocio.vsc-material-theme-icons
    ExodiusStudios.comment-anchors
    geeebe.duplicate
    JaimeOlivares.yuml
    joshpeng.theme-charcoal-oceanicnext
    jpoissonnier.vscode-styled-components
    kumar-harsh.graphql-for-vscode
    lunaryorn.fish-ide
    marcoms.oceanic-plus
    mgmcdermott.vscode-language-babel
    mikestead.dotenv
    ms-azuretools.vscode-docker
    ms-vscode.atom-keybindings
    Orta.vscode-jest
    ritwickdey.LiveServer
    sidneys1.gitconfig
    silvenon.mdx
    skyapps.fish-vscode
    sleistner.vscode-fileutils
    streetsidesoftware.code-spell-checker
    stylelint.vscode-stylelint
    tomoki1207.pdf
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
