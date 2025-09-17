
# enable tab completion for `g` by marking it as an alias for `git`
if which brew > /dev/null && [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi;

# re-initialise the shell's completion system with brew commands
if type brew &>/dev/null
then
  if [[ ":$FPATH:" != *":$(brew --prefix)/share/zsh/site-functions:"* ]]; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fi

  autoload -Uz compinit
  compinit
fi

# completions for switch user
source ~/.local/share/tomatao/git-switch-identity-completion.sh zsh
