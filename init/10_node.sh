#!/usr/bin/env bash

npm_globals=(
  bower
  grunt-cli
  gulp
  http-server
  karma-cli
  protractor
  yo
)

declare default_node="v0.10"

function nvm_set_current_node() {
  nvm install $default_node
  default_node="$(nvm current)"
  nvm alias default "$default_node"
  e_success "Installed Node $default_node and set as current"
}

function install_nvm() {
  curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

# Install Nvm
e_header "Installing Nvm"
if [[ "$(type -P curl)" ]]; then
  install_nvm
  nvm_set_current_node
else
  e_error "Needs CURL to install Nvm"
fi

# Update Npm
e_header "Updating Npm"
if [[ "$(type -P npm)" ]]; then
  npm install -g npm
else
  e_error "Node didn't work again :("
  return 1
fi

# Install Npm thingies
{
  pushd "$(npm config get prefix)/lib/node_modules";
  installed=(*);
  popd;
} > /dev/null

list="$(to_install "${npm_globals[*]}" "${installed[*]}")"

if [[ "$list" ]]; then
  e_header "Installing Npm modules: $list, for $default_node"
  npm install -g $list
fi

e_success "Nvm, Node and Npm setup :)"