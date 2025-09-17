function __fish_git_switch_identity_complete
  set -l cur (commandline -ct)

  set -l base "$XDG_CONFIG_HOME/git-identities.base.yml"
  set -l local "$XDG_CONFIG_HOME/git-identities.local.yml"


  if not test -f $base -a -f $local
    return
  end

  # Merge identities and list keys
  for id in (yq eval-all '
    . as $doc ireduce ({}; .identities *= ($doc.identities // {})) | .identities | keys | .[]
  ' $base $local 2>/dev/null)
    if string match -q "$cur*" $id
      echo $id
    end
  end
end

complete -c git-switch-identity -f -a "(__fish_git_switch_identity_complete)"
complete -c git -n '__fish_seen_subcommand_from su' -f -a "(__fish_git_switch_identity_complete)"
