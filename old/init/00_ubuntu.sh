#!/usr/bin/env bash

# Abort if not Ubuntu
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

e_header "Updating APT"

# Install APT packages. 
# build-essential and below req for pyenv
declare packages=(
  vim
  tree
  git
  curl
  parcellite
  vlc
  meld
  build-essential 
  libssl-dev
  zlib1g-dev
  libbz2-dev
  libreadline-dev
  libsqlite3-dev
  wget
  llvm
  make
)

# Go through the package manager checking if the package already exists
# if it doesn't, add it to the list
declare list=()
for package in "${packages[@]}"; do
  if [[ ! "$(dpkg -l "$package" 2>/dev/null | grep "^ii  $package")" ]]; then
    list=("${list[@]}" "$package")
  fi
done

if (( ${#list[@]} > 0 )); then
  e_header "Installing APT packages: ${list[*]}"
  for package in "${list[@]}"; do
    sudo apt-get install "$package"
    if [[ ! "$(type -P $package)" ]]; then
      e_error "$package failed..."
    else
      e_success "Installed $package"
    fi
  done
fi

e_success "Ubuntu specific install complete"