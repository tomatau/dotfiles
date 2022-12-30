
function git_has_commits -d "Check if is ahead or behind"
  git_is_repo; and begin
    test -n (echo \
      (command git rev-list --count --left-right "@{upstream}...HEAD" \
      2>/dev/null));
  end
end
