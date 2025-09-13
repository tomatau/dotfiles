alias dockerkillall='docker kill (docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n"; and docker rm (docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n"; and docker rmi (docker images -q -f dangling=true)'
alias dockerclean='dockercleanc; or true; and dockercleani'
