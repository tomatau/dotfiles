
function git_has_stashed -d "Check if has stashed"
  git_is_repo; and begin
    set -l git_dir (git rev-parse --git-dir)
    test -r $git_dir/refs/stash 2>/dev/null;
  end
end
