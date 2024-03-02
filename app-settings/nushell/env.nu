
$env.EDITOR = 'subl -w'
$env.PYENV_ROOT = $"($env.HOME)/.pyenv"
$env.GOPATH = $"($env.HOME)/Code/tomatao/go"
$env.NPM_TOKEN = 'REPLACE-ME'
$env.PGUSER = 'postgres'
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship-nushell.toml"

$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend '/usr/local/bin'
    | prepend '/usr/local/sbin'
    | prepend $"($env.HOME)/.bin"
    | prepend $"($env.HOME)/.cargo/bin"
    | prepend $"($env.GOPATH)/bin"
)

starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell | save -f ~/.zoxide.nu

if not (which fnm | is-empty) {
  ^fnm env --json | from json | load-env
  $env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend $"($env.FNM_MULTISHELL_PATH)/bin"
  )
}
