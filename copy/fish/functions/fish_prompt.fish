function __prompt_parent -a dir
  string replace $dir '' (prompt_pwd)
end

function __prompt_dir
  set -l dir (basename $PWD)
  set -l set_amber (set_color e69900)
  set -l set_yellow_bold (set_color -o FFCC66)

  switch "$PWD"
    case /
      echo -ns $set_yellow_bold '/'
    case "$HOME"
      echo -ns $set_yellow_bold '~'
    case '*'
      echo -ns $set_amber (__prompt_parent $dir) \
        $set_yellow_bold $dir
  end
end

function __start_segment -S -d 'Start a prompt segment'
  set -l right_arrow ▶
  set -l left_arrow ◀

  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal # clear out anything bold or underline...
  set_color -b $bg $fg $argv

  switch "$current_bg"
    case ''
      # If there's no background, just start one
      echo -n ' '
    case "$bg"
      # If the background is already the same color, draw a separator
      echo -ns $right_arrow ' '
    case '*'
      # otherwise, draw the end of the previous segment and the start of the next
      set_color $current_bg
      echo -ns $right_arrow ' '
      set_color $fg $argv
  end

  set current_bg $bg
end


function __finish_segments -S -d 'Close open prompt segments'
  set -l right_arrow ▶
  set -l left_arrow ◀

  if [ "$current_bg" != '' ]
    set_color normal
    set_color $current_bg
    echo -ns $right_arrow
  end

  set_color normal
  set current_bg
end

function __prompt_node_version
  echo -ns '⬢ ' (nvm current)
end

function fish_prompt
  set -l current_bg

  set -l set_normal (set_color normal)
  set -l set_green (set_color 4B7703)
  set -l set_blue (set_color blue)
  set -l set_tomato (set_color CD4A03)

  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end
  echo -ns $set_tomato (whoami)
  # echo -ns $set_blue ' @ '
  # echo -ns $set_green (prompt_hostname)
  echo -ns ' '
  __start_segment 222 # grey
  __prompt_dir
  echo -ns ' '
  __start_segment 4B7703 fff # green
  __prompt_node_version
  echo -ns ' '
  __finish_segments
  fish_prompt_git_status

  # Line 2
  echo
  if test $VIRTUAL_ENV
    printf "(%s) " \
      ($set_blue)\
      (basename $VIRTUAL_ENV)\
      ($set_normal)
  end
  echo -ns $set_normal '↪ '
end
