#!/usr/bin/env bash

setup-github-ssh() {
  p-header white "Starting SSH key setup..."

  local github_email="$1"
  local ssh_dir="$2"
  local private_key_path="$ssh_dir/$3"
  local pub_key_path="$ssh_dir/$3.pub"

  if [[ ! -d $ssh_dir ]]; then
    p-header white "Creating .ssh directory..."
    mkdir -p $ssh_dir
  fi

  if [[ ! -f $private_key_path ]]; then
    p-header purple "Generating private key..."
    ssh-keygen -t ed25519 \
      -C $github_email \
      -f $private_key_path \
      -N ""

    p-header purple "Starting agent..."
    eval "$(ssh-agent -s)"

    p-header purple "Adding key..."
    ssh-add $private_key_path
  else
    p-header green "Private key already exists..."
  fi

  github-authenticated() {
    ssh -i $private_key_path \
      -T "git@github.com" \
      -o IdentitiesOnly=yes \
      -o StrictHostKeyChecking=no \
      &>/dev/null

    local exit_status=$?
    if [ $exit_status -eq 1 ]; then
      return 0  # Authenticated
    elif [ $exit_status -eq 255 ]; then
      return 1  # Not authenticated
    else
      return 2  # Unexpected error
    fi
  }

  if ! github-authenticated; then
    p-header amber "Key not setup in GitHub..."

    p-header purple "Copying public key to clipboard..."
    pbcopy < $pub_key_path

    p-header white "Your public key has been copied to your clipboard..."
    p-header white "Go add the key at https://github.com/settings/keys"

    read -p "Press [Enter] to continue once you've added the key to GitHub..."

    if github-authenticated; then
      p-header green "Successfully connected to GitHub!..."
    else
      p-header red "Failed to connect to GitHub..."
    fi
  else
    p-header green "SSH key already authenticated with GitHub..."
  fi
}
