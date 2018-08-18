# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

export PATH

[[ -s ~/.bin/z/z.sh ]] && . ~/.bin/z/z.sh

# export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
# export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1
