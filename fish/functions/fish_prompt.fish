function __prompt_parent -a dir -d 'prompt_pwd without current dir'
  string replace $dir '' (prompt_pwd)
end

function __prompt_dir -d 'Show dir with current dir bolded'
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

function __prompt_node_version -d 'Show current node version'
  echo -ns '⏣ ' (nvm current)
end

function __bobthefish_prompt_status -S -a last_status \
  -d 'Display symbols for a non zero exit status, root and background jobs'
  set -l nonzero
  set -l superuser
  set -l bg_jobs
  set -l cant_write
  set -l nonzero_exit_glyph '! '
  set -l superuser_glyph '$ '
  set -l bg_job_glyph '% '
  set -l cant_write_glyph 'ǂ '
  set -l colour_initial_segment_exit ffffcc ce000f --bold
  set -l colour_initial_segment_cant ffffcc ce000f --bold
  set -l colour_initial_segment_su ffffcc 189303 --bold
  set -l colour_initial_segment_jobs ffffcc 255e87 --bold

  # Last exit was nonzero
  [ $last_status -ne 0 ]
    and set nonzero $nonzero_exit_glyph

  # if superuser (uid == 0)
  [ (id -u) -eq 0 ]
    and set superuser $superuser_glyph

  # Jobs display
  [ (jobs -l | wc -l) -gt 0 ]
    and set bg_jobs $bg_job_glyph

  not [ -w "$PWD" ]
    and set cant_write $cant_write_glyph

  if [ "$nonzero" -o "$superuser" -o "$bg_jobs" -o "$cant_write" ]
    __start_segment $colour_initial_segment_exit
    if [ "$nonzero" ]
      set_color normal
      set_color -b $colour_initial_segment_exit
      if [ "$theme_show_exit_status" = 'yes' ]
        echo -ns $last_status ' '
      else
        echo -n $nonzero_exit_glyph
      end
    end

    if [ "$superuser" ]
      set_color normal
      if [ -z "$FAKEROOTKEY" ]
        set_color -b $colour_initial_segment_su
      else
        set_color -b $colour_initial_segment_exit
      end

      echo -n $superuser_glyph
    end

    if [ "$bg_jobs" ]
      set_color normal
      set_color -b $colour_initial_segment_jobs
      echo -n $bg_job_glyph
    end

    if [ "$cant_write" ]
      set_color normal
      set_color -b $colour_initial_segment_cant
      echo -n $cant_write_glyph
    end
  end
end

function fish_prompt
  set -l last_status $status
  set -l current_bg

  set -l set_normal (set_color normal)
  set -l set_green (set_color 4B7703)
  set -l set_blue (set_color blue)
  set -l set_tomato (set_color CD4A03)

  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

  __bobthefish_prompt_status $last_status
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
