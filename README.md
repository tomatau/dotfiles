# Dotfiles

### Usage:
```shell
git clone git@github.com:tomatau/dotfiles.git
bash ./dotfiles/bin/dotfiles.sh
```

This will:

- copy all of the files from `/dotifles/bin` to `~/.bin` (except those with a `dotfiles_` prefix)
- run all the scripts in the `init` folder
    - installs Z, NVM for node, Pyenv for Python, Rbenv for Ruby and Phpbrew for PHP
        - installs configurable versions for each
    - installs a bunch of Ubuntu packages
    - TODO: make the OSX scripts work
    - TODO: somehow add the repos needed for ubuntu packages :S
- copies all the files from /dotfiles/copy/ to ~
    - .bash_profile/.bashrc/.gitconfig/.gitignore
    - the /copy/.shell folder contains other shell scripts all sourced inside .bashrc
    - you can add new files here they will all get picked up and sourced

All files have .sh to help editors know what's going on

I've aimed to keep it organised as I can but there's still slop in the php stuff, the prompt and a few other bits like what nvm does to the .bash_profile

Also, my github Username and Email are in the .gitconfig.

TODO: 
- ssh
- inputrc
- java?

Created by Thomas "tomatao" Hudspith-Tatham
credits to:

"Cowboy" Ben Alman - https://github.com/cowboy/dotfiles

mathiasbynens - https://github.com/mathiasbynens/dotfiles