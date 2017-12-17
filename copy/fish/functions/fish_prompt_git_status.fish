function fish_prompt_git_status
  set -l set_normal (set_color normal)
  set -l set_blue (set_color blue)
  set -l set_magenta (set_color magenta)
  set -l set_pink (set_color FF69B4)

  set -l dirty '!'
  set -l untracked '?'
  set -l staged '+'
  set -l ahead '↑'
  set -l behind '↓'
  # set -l diverged '⥄'
  set -l none '◦'
  set -l stashed '$'

  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

  if git_is_repo
    echo -ns $set_normal ' '
    echo -ns $set_blue '±'
    echo -ns $set_normal ' '
    echo -ns $set_magenta (git_branch_name)

    if git_is_touched or git_has_untracked or git_has_stashed
      echo -ns $set_normal ' '
      if git_has_changed
        echo -ns $set_pink $dirty
      end

      if git_has_untracked
        echo -ns $set_pink $untracked
      end

      if git_has_staged
        echo -ns $set_pink $staged
      end

      if git_has_stashed
        echo -ns $set_pink $stashed
      end
    end

    if git_has_commits
      echo -ns $set_normal ' '
      echo -ns (git_ahead $ahead $behind $none)
    end
  end
end
