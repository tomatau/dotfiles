#!/usr/bin/env bash

# npm_globals=(grunt-cli grunt-init linken bower node-inspector yo)
# alias nave_stable='nave use default stable nave_stable_2 $(node --version 2>/dev/null); src'

declare default_node="v0.10"

function nvm_set_current_node() {
  nvm install $default_node
  default_node="$(nvm current)"
  nvm alias default "$default_node"
  e_success "Installed Node $(nvm current)"
}

function install_nvm() {
  curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

# INSTALL NVM
e_header "Installing NVM"
if [[ "$(type -P curl)" ]]; then
  install_nvm
  nvm_set_current_node
else
  e_error "Needs CURL to install NVM"
fi

# UPDATE NPM
e_header "Updating NPM"
if [[ "$(type -P npm)" ]]; then
  npm install -g npm
else
  e_error "Node didn't work again :("
fi


# nave init.
# if [[ "$(type -P nave)" ]]; then
#   nave_default="$(nave ls | awk '/^default/ {print $2}')"
#   if [[ "$nave_default" && "$(node --version 2>/dev/null)" != "v$nave_default" ]]; then
#     node_path=~/.nave/installed/$nave_default/bin
#     if [[ -d "$node_path" ]]; then
#       PATH=$node_path:$(path_remove ~/.nave/installed/*/bin)
#     fi
#   fi
# fi