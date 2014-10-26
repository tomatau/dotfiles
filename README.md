# Dotfiles

### Usage:
```bash
git clone git@github.com:tomatau/dotfiles.git
bash ./dotfiles/bin/dotfiles.sh
```

This will:

- copy all of the files from `/dotifles/bin` to `~/.bin` (except those with a `dotfiles_` prefix)
- run all the scripts in the `init` folder
    - installs Z, NVM for node, Pyenv for Python, Rbenv for Ruby and Phpbrew for PHP
        - installs configurable versions for each
    - if Ubunti, install a bunch of packages
    - if OSX, install brew and some bundles
- copies all the files from /dotfiles/copy/ to ~
    - .bash_profile/.bashrc/.gitconfig/.gitignore
    - the /copy/.shell folder contains other shell scripts all sourced inside .bashrc
    - you can add new files here they will all get picked up and sourced
- also contains a bunch of config files for:
	- sublime text
	- icons for sublime text and iTunes

All files have .sh to help editors know what's going on

I've aimed to keep it organised as I can but there's still slop in the php stuff, the prompt and a few other bits like what nvm does to the .bash_profile

#### Things of Note

Doesn't install brew casks, you'll need to install some stuff manually:
- Sublime Text 3
- Google Chrome
- iTerm
    + keys for cmd+left and cmd+right
- divvy
- Karabinder
- cd to
- Firefox, Opera, Canary
- Redis Manager
- Text Mate
- Slack
- MacDown
- uTorrent
- LastPass
- CleanMyMac 2
- MySQL Workbench
- Sequel Pro

Node, Ruby and Php sometimes mess up, not sure why...

Also, my github Username and Email are in the .gitconfig.

#### Possible Todo List: 
- ssh
- java?

Created by Thomas "tomatao" Hudspith-Tatham
credits to:

"Cowboy" Ben Alman - https://github.com/cowboy/dotfiles

mathiasbynens - https://github.com/mathiasbynens/dotfiles