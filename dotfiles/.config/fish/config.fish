set -g fish_prompt_pwd_dir_length 2
set -Ux LSCOLORS fxefcxdxbxexexabagacad
set -gx GOPATH "$HOME/Code/tomatao/go"
set -gx NPM_TOKEN "REPLACEME"
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PGUSER "postgres"
set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx EDITOR "subl -w"
set -gx PAGER "moar"
set -gx STARSHIP_CONFIG "$HOME/.config/starship-fish.toml"
set -gx PROTO_HOME "$HOME/.proto"

# Paths

set PATH /opt/homebrew/bin /usr/local/bin /opt/X11/bin /usr/local/sbin $PATH

if test -d "$GOPATH/bin"
    fish_add_path "$GOPATH/bin"
end

if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end

if test -d "$HOME/.bin"
    fish_add_path "$HOME/.bin"
end

if test -d "$PROTO_HOME/shims"
    fish_add_path "$PROTO_HOME/shims"
end

if test -d "$PROTO_HOME/bin"
    fish_add_path "$PROTO_HOME/bin"
end

# Aliases

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ls="lsd"
alias l='ls -lF'
alias ll='ls -lF --ignore-config'
alias la='ls -AlF'
alias laa='ls -AlF --ignore-config'
alias las='ls -AlFS'
alias lt='ls --tree -d'
alias lta='ls --tree --ignore-config'

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
