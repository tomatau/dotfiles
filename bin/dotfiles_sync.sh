#!/usr/bin/env bash

e_header "Syncing dotfiles"

if [[ ! -d ~/.dotfiles ]]; then
    new_dotfiles_install=1
else
    read -p "Overwrite existing dotfiles? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        e_error "Aborting"
        exit;
    fi
fi


dotfiles_location=${PWATH%/*} | awk -F_ '{print $1}'
echo "PWATH ${PWATH}"

rsync -av --exclude ".git/" --exclude ".DS_Store" \
    --exclude "bin/dotfiles.sh" --exclude "bin/dotfiles_requirements.sh" \
    --exclude "bin/dotfiles_functions.sh" --exclude "bin/dotfiles_sync.sh" \
    --exclude "README.md" "$PWATH/../.." ~
    # --exclude "init" --exclude "copy" --exclude "alias" \

if [[ "$new_dotfiles_install" != 1 ]]; then
    e_header "Removing old dotfiles"
    rm -rf ~/.dotfiles
fi

mv ~/dotfiles ~/.dotfiles

e_success "Updated dotfiles folder"