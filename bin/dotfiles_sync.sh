#!/usr/bin/env bash

e_header "Syncing dotfiles bin"

if [[ ! -d ~/.bin ]]; then
  new_dotfiles_install=1
else
  read -p "Overwrite existing .bin? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    e_error "Aborting"
    exit;
  fi
fi

dotfiles_location=${PWATH%/*} | awk -F_ '{print $1}'

rsync -av --exclude ".git/" --exclude ".DS_Store" \
  --exclude "dotfiles.sh" --exclude "dotfiles_requirements.sh" \
  --exclude "dotfiles_functions.sh" --exclude "dotfiles_sync.sh" \
  --exclude "init" --exclude "copy" --exclude "alias" --exclude "tmp" \
  --exclude "README.md" "$PWATH/.." ~

if [[ "$new_dotfiles_install" != 1 ]]; then
  e_header "Removing old bin"
  rm -rf ~/.bin
fi

mv ~/bin ~/.bin

e_success "Updated dotfiles bin"