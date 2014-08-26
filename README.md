# Dotfiles

### Usage:
```
git clone git@github.com:tomatau/dotfiles.git
bash ./dotfiles/bin/dotfiles.sh
```

This will:

- copy all of the files from /dotifles/bin to ~/.bin (except those with dotfiles prefix)
- run all the scripts in init
    - installs Z, NVM for node, Pyenv for Python, Rbenv for Ruby and Phpbrew for PHP
        - TODO: some checks in installed versions of python and php
        - TODO: checks on installed Ubuntu packages when dependencies
    - installs a bunch of Ubuntu packages
    - TODO: make the OSX script work
- copies all the files from /dotfiles/copy/ to ~
    - .bash_profile/.bashrc/.gitconfig/.gitignore
    - the /copy/.shell folder contains other shell scripts all sourced inside .bashrc
    - you can add new files here they will all get picked up and sourced
    - TODO: fix up the OSX shell script

All files have .sh to help editors know what's going on

I've aimed to keep it organised as I can but there's still slop in the php stuff, the prompt and a few other bits like what nvm does to the .bash_profile

Also, my github Username and Email are in the .gitconfig.




Created by Thomas "tomatao" Hudspith-Tatham
credits to:
"Cowboy" Ben Alman - https://github.com/cowboy/dotfiles
mathiasbynens - https://github.com/mathiasbynens/dotfiles