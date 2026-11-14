
function prepend_path() {
  local dir="$1"

  if ! [[ -d "$dir" ]]; then
    return
  fi

  remove_from_path "$dir"

  export PATH="$dir${PATH:+:$PATH}"
}

function remove_from_path() {
  local dir="$1"
  local padded_path=":$PATH:"

  while [[ "$padded_path" == *":$dir:"* ]]; do
    padded_path="${padded_path/":$dir:"/:}"
  done

  padded_path="${padded_path#:}"
  export PATH="${padded_path%:}"
}

# system packages
prepend_path "/usr/local/bin"
prepend_path "/opt/homebrew/sbin"
prepend_path "/opt/homebrew/bin"

# language packages
prepend_path "$GOPATH/bin"
prepend_path "$HOME/.cargo/bin"

# version management
prepend_path "$PROTO_HOME/bin"
prepend_path "$PROTO_HOME/shims"

# my overrides
prepend_path "$HOME/.local/bin"

# Added by LM Studio CLI (lms)
prepend_path "$HOME/.cache/lm-studio/bin"
# End of LM Studio CLI section

# Added by Docker Desktop
prepend_path "$HOME/.docker/bin"
# End of Docker Desktop section

# Antigravity IDE
prepend_path "$HOME/.antigravity-ide/antigravity-ide/bin"

export PATH
