#!/usr/bin/env bash

if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  # enable tab completion for `g` by marking it as an alias for `git`
  complete -o default -o nospace \
    -F "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" \
    g;

  # many bash commands
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi

# completions for switch user
source ~/.local/share/tomatao/git-switch-identity-completion.sh bash
