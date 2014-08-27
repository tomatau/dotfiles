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

declare default_node="v0.10.31"
declare node_versions=(
  "$default_node"
)

function get_nvm_versions() {
  local installed=()
  for path in "$HOME/.nvm/"*; do
    if [ `expr "${path##*/}" : "v[0-9]*\.[0-9]*\.[0-9]*$"` != 0 ]; then
      if [ -d "$path" ]; then
        installed=("${installed[@]}" "${path##*/}")
      fi
    fi
  done
  echo "${installed[*]}"
}

function nvm_set_current_node() {
  for v in $(to_install "${node_versions[*]}" "$(get_nvm_versions)"); do
    nvm install "$v"
  done
  # default_node="$(nvm current)"
  nvm alias default "$default_node"
  e_success "Installed Node $default_node and set as current"
}

function install_nvm() {
  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  fi
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

e_header "Installing Npm Modules"
{
  pushd "$(npm config get prefix)/lib/node_modules";
  installed=(*);
  popd;
} > /dev/null

list="$(to_install "${npm_globals[*]}" "${installed[*]}")"

if [[ "$list" ]]; then
  e_header "modules: $list, for $default_node"
  npm install -g $list
fi

e_success "Nvm, Node and Npm setup :)"