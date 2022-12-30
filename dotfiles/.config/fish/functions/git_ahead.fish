
function git_ahead -a ahead behind none
  not git_is_repo; and return

  set -l commit_count \
    (command git rev-list \
      --count \
      --left-right "@{upstream}...HEAD" \
    2>/dev/null)
  echo $commit_count | read -l behind_count ahead_count

  switch "$commit_count"
  case ""
    return
  case "0"\t"0"
    echo -ns (set_color 555) "[ $none ]"
  case "*"
    echo -ns (set_color 555) "[ "
    switch "$behind_count"
    case "0"
      echo -ns (set_color aaa)
    case "*"
      echo -ns (set_color red)
    end
    echo -ns $behind_count $behind

    echo -ns (set_color normal) " "

    switch "$ahead_count"
    case "0"
      echo -ns (set_color aaa)
    case "*"
      echo -ns (set_color green)
    end
    echo -ns $ahead_count $ahead
    echo -ns (set_color 555) " ]"
  end
end
