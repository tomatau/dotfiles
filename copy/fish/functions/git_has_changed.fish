
function git_has_changed -d "Check if has modified files"
  git_is_repo; and begin
    test -n (echo (command git diff --name-status))
  end
end
