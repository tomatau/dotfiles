function fish_right_prompt
  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

  if test 70 -lt $COLUMNS
    set_color 555
    fish_prompt_cmd_duration
    echo -ns ' ~ '
    echo -ns (command date "+%H:%M:%S ~ %d %b")
    set_color $fish_color_normal
  end
end
