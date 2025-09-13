
function prepend_path() {
  local dir="$1"

  if ! [[ -d "$dir" ]]; then
    return
  fi

  remove_from_path $dir

  export PATH="$dir${PATH:+:$PATH}"
}

function remove_from_path() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

# language packages
prepend_path "$GOPATH/bin"
prepend_path "$HOME/.cargo/bin"

# system packages
prepend_path "$HOME/.local/bin"
prepend_path "/usr/local/bin"
prepend_path "/opt/homebrew/sbin"
prepend_path "/opt/homebrew/bin"

# version management
prepend_path "$PROTO_HOME/shims"

# my overrides
prepend_path "$HOME/.bin"

export PATH
