#!/usr/bin/env bash

# Git-switch-identity tab completion for bash, zsh, and fish
# Usage: source git-switch-identity-completion.sh <shell>

SHELL_TYPE="${1:-bash}"

_merge_identities() {
  local base="$XDG_CONFIG_HOME/git-identities.base.yml"
  local local="$XDG_CONFIG_HOME/git-identities.local.yml"
  yq eval-all '. as $doc ireduce ({}; .identities *= ($doc.identities // {})) | .identities | keys | .[]' "$base" "$local" 2>/dev/null
}

case "$SHELL_TYPE" in
  bash)
    _git_switch_identity_bash() {
      local cur="${COMP_WORDS[COMP_CWORD]}"
      COMPREPLY=( $(compgen -W "$(_merge_identities)" -- "$cur") )
    }

    complete -F _git_switch_identity_bash git-switch-identity
    complete -F _git_switch_identity_bash git su
    ;;
  zsh)
    _git_switch_identity_zsh() {
      reply=( $(_merge_identities) )
    }

    compctl -K _git_switch_identity_zsh git-switch-identity
    compctl -K _git_switch_identity_zsh git su
    ;;
  *)
    echo "Unsupported shell: $SHELL_TYPE" >&2
    return 1
    ;;
esac
