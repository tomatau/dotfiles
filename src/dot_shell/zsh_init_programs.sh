#!/usr/bin/env zsh

if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook zsh)"
fi

if [ -x "$(command -v pyenv)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
fi

if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

if [ -x "$(command -v starship)" ]; then
  eval "$(starship init zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
  . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi

__conda_path="$(brew --prefix)/anaconda3";
__conda_setup="$($__conda_path/bin/conda 'shell.bash' 'hook' 2> /dev/null)";
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$__conda_path/etc/profile.d/conda.sh" ]; then
        . "$__conda_path/etc/profile.d/conda.sh"
    else
        export PATH="$__conda_path/bin:$PATH"
    fi
fi
unset __conda_path
unset __conda_setup

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
