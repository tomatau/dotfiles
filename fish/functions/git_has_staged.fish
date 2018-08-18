
function git_has_staged -d "Check if has staged"
  git_is_repo; and begin
    not command git diff --cached --no-ext-diff --quiet --exit-code
  end
end
