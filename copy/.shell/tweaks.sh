#!/bin/bash

export GREP_OPTIONS='--color=auto'

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Faster npm for Europeans <3
command -v npm > /dev/null && alias npme="npm --registry http://registry.npmjs.eu/"

export EDITOR='subl -w'
# export LESSEDIT='subl %f'
# export VISUAL="$EDITOR"

# export NOSE_REDNOSE=1 # colors