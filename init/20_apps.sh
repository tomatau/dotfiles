#!/usr/bin/env bash

# Abort if not OSX
[[ "$OSTYPE" =~ ^darwin ]] || return 1

declare app_settings_path="$PARENT/app-settings"
declare app_support_path="$HOME/Library/Application Support"

# iTerm2

e_header "Copying iTerm2 profiles"

local iTerm2_support_path="$app_support_path/iTerm2/DynamicProfiles/"

if [[ ! -d "$iTerm2_support_path" ]]; then
    mkdir -p "$iTerm2_support_path"
fi
cp "$app_settings_path/iTerm2.json" "$iTerm2_support_path"

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

# Nushell

e_header "Copy Nushell Settings"

local nushell_suppprt="$app_support_path/nushell/"

if [[ -d "$nushell_suppprt_path" ]]; then
    e_header "Merging Nushell Settings"
    cat "$app_settings_path/nushell/env.nu" >> "$nushell_suppprt_path/env.nu"
    cat "$app_settings_path/nushell/config.nu" >> "$nushell_suppprt_path/config.nu"
fi

# TextMate

e_header "Install TextMate Settings"

local textmate_bundles_path="$app_support_path/TextMate/Managed/Bundles/"
if [[ -d "$textmate_bundles_path" ]]; then
    cd $textmate_bundles_path
    git clone git://github.com/l15n/fish-tmbundle.git "Fish.tmbundle"
fi

# VSCode

e_header "Install Code Extensions"
code_packages=(
    asvetliakov.snapshot-tools
    bierner.markdown-mermaid
    bpruitt-goddard.mermaid-markdown-syntax-highlighting
    christian-kohler.npm-intellisense
    christian-kohler.path-intellisense
    cssho.vscode-svgviewer
    dbaeumer.vscode-eslint
    dunstontc.viml
    eamodio.gitlens
    editorconfig.editorconfig
    equinusocio.vsc-material-theme
    equinusocio.vsc-material-theme-icons
    esbenp.prettier-vscode
    exodiusstudios.comment-anchors
    geeebe.duplicate
    github.vscode-github-actions
    golang.go
    jaimeolivares.yuml
    jinxdash.prettier-rust
    joshpeng.theme-charcoal-oceanicnext
    kumar-harsh.graphql-for-vscode
    lunaryorn.fish-ide
    marcoms.oceanic-plus
    mechatroner.rainbow-csv
    mgmcdermott.vscode-language-babel
    mikestead.dotenv
    ms-azuretools.vscode-docker
    ms-dotnettools.vscode-dotnet-runtime
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-python.black-formatter
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.datawrangler
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    ms-vscode.atom-keybindings
    orta.vscode-jest
    pflannery.vscode-versionlens
    redhat.vscode-yaml
    ritwickdey.liveserver
    rust-lang.rust-analyzer
    serayuzgur.crates
    sidneys1.gitconfig
    simonsiefke.svg-preview
    skyapps.fish-vscode
    sleistner.vscode-fileutils
    sourcegraph.cody-ai
    streetsidesoftware.code-spell-checker
    styled-components.vscode-styled-components
    tamasfe.even-better-toml
    thenuprojectcontributors.vscode-nushell-lang
    tomoki1207.pdf
    travisthetechie.write-good-linter
    tyriar.sort-lines
    vscode-icons-team.vscode-icons
    whizkydee.material-palenight-theme
    wmaurer.change-case
    yoavbls.pretty-ts-errors
    yzhang.markdown-all-in-one
    znck.grammarly
)
for package in "${code_packages[@]}"; do
    code --install-extension $package
done

e_header "Copy VSCode Settings"

if [[ ! -d "$app_support_path/Code/User" ]]; then
    mkdir -p "$app_support_path/Code/User"
fi

cp -r "$app_settings_path/code/" "$app_support_path/Code/User"
