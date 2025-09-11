# Dotfiles

## Usage:

```bash
git clone git@github.com:tomatau/dotfiles.git
bash ./dotfiles/bin/dotfiles.sh
```

This will:

- copy the files from `/dotfiles/bin` to `~/.bin` (except those with a `dotfiles_` prefix)
- run all the scripts in the `/init/` folder
  - installs `brew`, `fnm`, `pyenv`, etc...
- copies all the files from `/dotfiles/` to `~`
  - `.bash_profile`, `.bashrc`, `.zshrc`, `.config`, `.gitconfig`, etc..
  - the `/dotfiles/.shell` folder contains other shell scripts all sourced inside `.bashrc`
- also contains a bunch of config files for:
  - VSCode
  - Sublime Text
  - Vim
  - Nushell
  - Fish
  - Karabinder mappings

## Notes

- My Github username and email are in the .gitconfig.

## Thanks to

I took a bunch of bash from these repos as I'm terrible at it...

- https://github.com/cowboy/dotfiles
- https://github.com/mathiasbynens/dotfiles
