#!/usr/bin/env bash

e_header "Syncing dotfiles bin"

if [[ ! -d ~/.bin ]]; then
  new_dotfiles_install=1
fi

read -p "Overwrite existing .bin? [following install may break if not](y/n) " -n 1;
echo "";

if [[ $REPLY =~ ^[Nn]$ ]]; then
  e_header "Skipped ~/.bin overwrite"
else
  rsync -av \
    --exclude ".DS_Store" \
    --exclude ".git/" \
    --exclude ".gitignore" \
    --exclude ".gitmodules" \
    --exclude "app-settings" \
    --exclude "dotfiles_functions.sh" \
    --exclude "dotfiles_requirements.sh" \
    --exclude "dotfiles_sync.sh" \
    --exclude "dotfiles.sh" \
    --exclude "dotfiles" \
    --exclude "editor-settings" \
    --exclude "init" \
    --exclude "README.md" \
    --exclude "tmp" \
    "$PWATH/.." ~

  if [[ "$new_dotfiles_install" != 1 ]]; then
    e_header "Removing old bin"
    rm -rf ~/.bin
  fi

  mv ~/bin ~/.bin

  e_success "Updated dotfiles bin"
fi
