
function git_ahead -a ahead behind none
  not git_is_repo; and return

  set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" ^/dev/null)
  echo $commit_count | read -l behind_count ahead_count

  switch "$commit_count"
  case ""
    return
  case "0"\t"0"
    echo -n -s (set_color 555) "[ $none ]"
  case "*"
    echo -n -s (set_color 555) "[ "
    switch "$behind_count"
    case "0"
      echo -n -s (set_color aaa)
    case "*"
      echo -n -s (set_color red)
    end
    echo -n -s $behind_count $behind

    echo -n -s (set_color normal) " "

    switch "$ahead_count"
    case "0"
      echo -n -s (set_color aaa)
    case "*"
      echo -n -s (set_color green)
    end
    echo -n -s $ahead_count $ahead
    echo -n -s (set_color 555) " ]"
  end
end
