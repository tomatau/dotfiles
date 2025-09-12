
function add_to_path_if_exists() {
  local dir="$1"
  local colon_path="${PATH//:/:}"
  colon_path="${colon_path// //}"

  if ! [ -d "$dir" ]; then
    return
  fi

  if ! [[ $colon_path == *":$dir:"* ]]; then
    export PATH="$PATH:$dir"
  fi
}

function remove_from_path() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

# my overrides
add_to_path_if_exists "$HOME/.bin"

# version management
add_to_path_if_exists "$PROTO_HOME/shims"

# system packages
eval "$(/opt/homebrew/bin/brew shellenv)"
add_to_path_if_exists "/usr/local/bin"
add_to_path_if_exists "$HOME/.local/bin"

# language packages
add_to_path_if_exists "$HOME/.cargo/bin"
add_to_path_if_exists "$GOPATH/bin"

export PATH
