#!/usr/bin/env bash

function e_header() { echo -e "\n\033[1m$@\033[0m"; }
function e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error() { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow() { echo -e " \033[1;33m➜\033[0m  $@"; }

function init_run() {
  source "$2"
}

function copy_do() {
  e_header "Copying ~/$1."
  cp "$2" ~/
  e_success "Copied $1"
}

function run_directory() {
  local base dest
  local files=(~/.dotfiles/$1/*)
  
  if (( ${#files[@]} == 0 )); then return; fi
  
  # display any header
  # [[ $(declare -f "$1_header") ]] && "$1_header"

  for file in "${files[@]}"; do
    base="$(basename $file)"
    dest="$HOME/$base"
    echo $file

    [[ $(declare -f "$1_run") ]] && "$1_run" "$base" "$file"
  done
}

# desired items and installed items, return difference
# - either space or newline seperated lists
function to_install(){
  local debug desired installed i desired_s installed_s remain
  if [[ "$1" == "-d" ]]; then debug=1; shift; fi
  # Convert args to arrays, handling both space- and newline-separated lists.
  read -ra desired < <(echo "$1" | tr '\n' ' ')
  read -ra installed < <(echo "$2" | tr '\n' ' ')

  unset i; while read -r; do desired_s[i++]=$REPLY; done < <(
    printf "%s\n" "${desired[@]}" | sort
  )
  unset i; while read -r; do installed_s[i++]=$REPLY; done < <(
    printf "%s\n" "${installed[@]}" | sort
  )
  # Get the difference. comm is awesome.
  unset i; while read -r; do remain[i++]=$REPLY; done < <(
    comm -13 <(printf "%s\n" "${installed_s[@]}") <(printf "%s\n" "${desired_s[@]}")
  )
  
  [[ "$debug" ]] && for v in desired desired_s installed installed_s remain; do
    echo "$v ($(eval echo "\${#$v[*]}")) $(eval echo "\${$v[*]}")"
  done
  echo "${remain[@]}"
}