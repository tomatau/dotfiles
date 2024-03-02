
def --env take [directory: path] {
    mkdir $directory; cd $directory
}

alias ls = lsd
alias l = ls -lF
alias ll = ls -lF --ignore-config
alias la = ls -AlF
alias laa = ls -AlF --ignore-config
alias las = ls -AlFS
alias lt = ls --tree -d
alias lta = ls --tree --ignore-config

alias o = ^open
alias g = git
alias reload = exec $env.SHELL -l

use ~/.cache/starship/init.nu
source ~/.zoxide.nu
