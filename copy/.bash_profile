# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

[[ -s ~/.bin/z/z.sh ]] && . ~/.bin/z/z.sh

PATH="/usr/local/heroku/bin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"
PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

export PATH

export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
export DOCKER_CERT_PATH=/Users/tomatao/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

[[ -s ~/.phpbrew/bashrc ]] && source $HOME/.phpbrew/bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
fi