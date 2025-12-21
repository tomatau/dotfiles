
# zsh-autosuggestions
if which brew > /dev/null && [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi;

# Docker completions
if [ -d "$HOME/.docker/completions" ]; then
  FPATH="$HOME/.docker/completions:$FPATH"
fi

# Homebrew completions
if type brew &>/dev/null; then
  brew_fpath="$(brew --prefix)/share/zsh/site-functions"
  if [[ -d "$brew_fpath" && ":$FPATH:" != *":$brew_fpath:"* ]]; then
    FPATH="$brew_fpath:$FPATH"
  fi
fi

# re-initialise the shell's completion system
autoload -Uz compinit
compinit

# Custom completions rely on compinit
if [ -f ~/.local/share/tomatao/git-switch-identity-completion.sh ]; then
  source ~/.local/share/tomatao/git-switch-identity-completion.sh zsh
fi
