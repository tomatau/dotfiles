#!/usr/bin/env bash

# Can remove the .31 here to just install the latest
# should uncomment the default_node="$(nvm current)" too
declare default_node="v12.16.1"
declare node_versions=(
  "$default_node"
  v13.11.0
)
declare npm_globals=(
  ndb
  # http-server
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
  nvm alias stable "$default_node"
  e_success "Installed Node $default_node and set as current"
}

function install_nvm() {
  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    export NPM_TOKEN="tmp-abc-1234" # fix bug with .npmrc
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
  npm install -g npm yarn
else
  e_error "Npm was not installed correctly :/"
  return 1
fi

e_header "Installing Npm Modules"
{
  pushd "$(npm config get prefix)/lib/node_modules";
  installed=(*);
  popd;
} > /dev/null
npm_list="$(to_install "${npm_globals[*]}" "${installed[*]}")"
if [[ "$npm_list" ]]; then
  e_header "Npm modules: $npm_list, for $default_node"
  npm install -g $npm_list
fi

e_success "Nvm, Node and Npm setup :)"
