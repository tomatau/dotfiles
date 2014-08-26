#!/usr/bin/env bash

target=~/.bin

e_header "Installing rupa's Z"

if [[ -d $target ]]; then
  {
    pushd "$target"
    git clone https://github.com/rupa/z.git
    chmod +x ./z/z.sh
    # ln -s "$target"/z/z.sh z.sh # link to ./bin/z.sh in path
    popd
  } > /dev/null
  e_success "Installed Z"
else
  e_error "Z needs $target to install to!"
fi
