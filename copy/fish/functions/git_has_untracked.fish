
function git_has_untracked -d "Check if is ahead or behind"
  git_is_repo; and begin
    test -n (echo (command git ls-files --other --exclude-standard ^/dev/null))
  end
end
