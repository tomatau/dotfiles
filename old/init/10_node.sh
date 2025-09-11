#!/usr/bin/env bash

declare default_node="v20"
declare node_versions=(
  "$default_node"
)
declare npm_globals=(
  npm
  yarn
  pnpm
)

function fnm_set_current_node() {
  for v in $node_versions; do
    fnm install "$v"
  done
  fnm alias "$default_node" stable
  e_success "Installed Node $default_node and set as current"
}

e_header "Installing node versions"
fnm_set_current_node

e_header "Npm modules for $default_node = $npm_globals"
npm install -g $npm_globals

e_success "Fnm, Node and Npm setup :)"
