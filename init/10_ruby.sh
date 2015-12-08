#!/usr/bin/env bash

declare default_ruby=2.1.2
declare ruby_versions=(
  "$default_ruby"
  2.1.5
  2.2.1
)
declare ruby_gems=(
  bundler
)

function get_ruby_versions() {
    local installed=()
    for path in "$HOME/.rbenv/versions/"*; do
        if [ `expr "${path##*/}" : "[0-9]*\.[0-9]*\.[0-9]*$"` != 0 ]; then
          if [ -d "$path" ]; then
            installed=("${installed[@]}" "${path##*/}")
          fi
        fi
    done
    echo "${installed[*]}"
}

e_header "Installing Rbenv"
if [[ ! "$(type -P rbenv)" ]]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  # TODO: add check here
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  e_success "Installed Rbenv"

  # TODO: add check here
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  e_success "Installed Ruby-Build"
else
  e_header "Rbenv already installed :)"
fi

e_header "Installing Ruby"
# if [[ ! "$(type -P ruby)" ]]; then # assumes no global ruby
if [[ "$(type -P rbenv)" ]]; then
  for v in $(to_install "${ruby_versions[*]}" "$(get_ruby_versions)"); do
    rbenv install "${v}"
    e_success "Installed Ruby ${default_ruby}"
  done
  rbenv global "${default_ruby}"
  rbenv rehash
  e_success "Set Ruby ${default_ruby} as global"
else
  e_header "Rbenv did not install :/"
fi

# Install Gems.
e_header "Installing Ruby Gems"
if [[ "$(type -P gem)" ]]; then
  list="$(to_install "${ruby_gems[*]}" "$(gem list | awk '{print $1}')")"
  if [[ "$list" ]]; then
    e_header "Installing Ruby gems: $list"
    gem install $list
    rbenv rehash
  fi
else
  e_error "Gem's can't be installed :/"
  return 1
fi

e_success "Rbenv, Ruby and Gems setup :)"