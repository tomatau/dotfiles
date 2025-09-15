# Dotfiles

System configuration files and scripts for `tomatau` on MacOS powered by chezmoi.

## Usage

## Installation

Install, initialise and run `chezmoi` on macOS:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init \
	--apply $GITHUB_USERNAME \
	--source /path/to/your/dotfiles-repo
```

The initialisation stage will prompt for:

- Whether setting up a `work` machine or `personal` machine
- If this is a work machine, it will further prompt for a GitHub username and email

Next, it will apply the `chezmoi` repo:

- Install `xcode-select` if it's not already installed
- Install `brew` for package management
- Run `rustup-init` as some formulas can depend on it
- Install brew formulas, casks, and VS Code extensions
- Setup system shells for `zsh`, `bash`, and `fish` using updated `brew` binaries
- Set the default shell to `$(brew --prefix)/bin/zsh`
- Create a `~/Code` directory and a directory for Golang
- Copy the dotfiles for:

  - `.config/fish`
  - `.config/gh`
  - `.config/lsd`
  - `.config/karabiner`
  - `.config/zed`
  - `.config/starship`
  - `.zshrc` and `.bashrc`, sharing config in `~/.shells` for env_vars and aliases
  - `.condarc`
  - `.gitconfig`
  - `.inputrc`
  - `.sqliterc`
  - `.vimrc`
  - etc.

- Copy ~/Library settings for
  - VS Code
  - iTerm2
  - Sublime Text
  - Ghostty
- Install vim plugins with pathogen
- Install TextMate plugins
- Configure `fzf`
- Look for an NPM token in LastPass notes based on the machine's hostname
- Install fisher plugins for fish
- Install latest and LTS node versions with FNM
- Enable `corepack` by default
- Install `bun`, `deno`, `go`, and `uv` with `proto`
- Apply MacOS settings

## Manual steps

Not everything is friendly and supporting dotfiles.

- Import the Raycast settings from `manual/Raycast.rayconfig`

## Features

- **Idempotency**: Scripts attempt to be re-runnable without breaking state.
- **Profiles**: for `personal` and `work`.
- **Shell Customization**: Includes aliases, functions, and prompt themes for Bash, Zsh, and Fish.
- **Dependency management**: Using brew.
- **Version Managers**: Pre-configured for Node.js (`fnm`), Python (`pyenv` but prefer `uv`), and other languages using `proto` and `asdf`.
- **Editor Configurations**: Optimized settings for VSCode, Sublime Text, Zed, and Vim.
- **Git Setup**: Includes `.gitconfig` with user details, aliases, and tweaks.
- **Key Mappings**: Custom keyboard shortcuts using Karabiner.
- **Terminal Tools**: Configurations for `starship`, `fzf`, `fish`, etc.
- **Password Manager Integration**: Using LastPass.
- **OSX System settings**: executing a `.osx` dotfile.
- **Minimal changes**: only update dotfiles or sections when changed.
