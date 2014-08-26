#!/usr/bin/env bash

ruby_gems=(
  sass
)
current_stable=2.1.2

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

if [[ ! "$(type -P ruby)" ]]; then
  rbenv install "${current_stable}"
  e_success "Installed Ruby ${current_stable}"

  rbenv global "${current_stable}"
  rbenv rehash
  e_success "Set Ruby ${current_stable} as global"
else
  e_header "Ruby already installed :)"
fi

# Install Gems.
if [[ "$(type -P gem)" ]]; then

  list="$(to_install "${ruby_gems[*]}" "$(gem list | awk '{print $1}')")"
  if [[ "$list" ]]; then
    e_header "Installing Ruby gems: $list"
    gem install $list
    rbenv rehash
  fi
else
  e_header "Gem already installed :)"
fi