#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
  >&2 echo "Usage: $0 FILENAME[:LINENO]"
  exit 1
fi

file=${1/#\~\//$HOME/}
center=0

if [[ ! -r $file ]]; then
  if [[ $file =~ ^(.+):([0-9]+)\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  fi
fi

type=$(file --brief --mime -- "$file")

if [[ $type =~ text/ ]]; then
  bat --style=numbers --color=always --pager=never --highlight-line="${center:-0}" -- "$file"
elif [[ $type =~ application/json ]]; then
  bat --style=numbers --color=always --pager=never -- "$file"
elif [[ $type =~ application/toml ]]; then
  bat --style=numbers --color=always --pager=never -- "$file"
elif [[ $type =~ image/ ]]; then
  if command -v chafa > /dev/null; then
    chafa -s "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" "$file"
  else
    echo "Image preview not supported"
  fi
else
  echo "Unsupported file type: $type"
fi
