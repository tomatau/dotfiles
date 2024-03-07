set -g fish_prompt_pwd_dir_length 2
set -Ux LSCOLORS fxefcxdxbxexexabagacad
set -x GOPATH "$HOME/Code/tomatao/go"
set -x NPM_TOKEN "REPLACEME"
set -x PNPM_HOME "$HOME/Library/pnpm"
set -x PGUSER "postgres"
set -x PYENV_ROOT "$HOME/.pyenv"
set -x EDITOR "subl -w"
set -x PAGER "moar"
set -x STARSHIP_CONFIG "$HOME/.config/starship-fish.toml"

# Paths

set PATH /opt/homebrew/bin /usr/local/bin /opt/X11/bin /usr/local/sbin $PATH

if test -d "$PYENV_ROOT/bin"
    fish_add_path "$PYENV_ROOT/bin"
end

if test -d "$GOPATH/bin"
    fish_add_path "$GOPATH/bin"
end

if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.bin"
end

if test -d "$HOME/.bin"
    fish_add_path "$HOME/.bin"
end

# Aliases

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Initialisers

if command -q direnv
    direnv hook fish | source
end

if command -q pyenv
    pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source
end

if command -q fnm
    fnm env --use-on-cd | source
end

if command -q zoxide
    zoxide init fish | source
end

if command -q starship
    starship init fish | source
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $(brew --prefix)/anaconda3/bin/conda
    eval $(brew --prefix)/anaconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
