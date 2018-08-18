function fish_prompt_cmd_duration -d 'Show command duration'
  if [ "$CMD_DURATION" -lt 5000 ]
    echo -ns $CMD_DURATION 'ms'
  else if [ "$CMD_DURATION" -lt 60000 ]
    pretty_ms $CMD_DURATION s
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color $fish_color_error
    pretty_ms $CMD_DURATION m
  else
    set_color $fish_color_error
    pretty_ms $CMD_DURATION h
  end
end
