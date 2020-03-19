#!/usr/bin/env bash

e_header "Installing rupa's Z"

if [[ -d ~/.bin ]]; then
  if [[ ! -s ~/.bin/z/z.sh ]]; then
    {
      pushd ~/.bin
      git clone https://github.com/rupa/z.git
      [[ -s ~/.bin/z/z.sh ]] && chmod +x ~/.bin/z/z.sh
      popd
    } > /dev/null
    e_success "Installed Z"
  else
    e_header "Z Already installed :)"
  fi
else
  e_error "Z needs $target to install to!"
fi
