function fish_prompt
	set -l set_normal (set_color normal)
	set -l set_green (set_color 4B7703)
	set -l set_blue (set_color blue)
	set -l set_tomato (set_color CD4A03)
	set -l set_yellow (set_color FFCC66)

	if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

	echo -n -s $set_tomato (whoami)
  echo -n -s $set_blue ' @ '
  echo -n -s $set_green (prompt_hostname)
  echo -n -s $set_normal ' '
	echo -n -s $set_yellow (prompt_pwd)

  # Line 2
  echo

  if test $VIRTUAL_ENV
      printf "(%s) " ($set_blue)(basename $VIRTUAL_ENV)($set_normal)
  end

	echo -n -s $set_normal '↪ '
end
