# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

echo "$(type $binroot/yo)"
if [[ "$(type $binroot/yo)" &&  ! "$(cat /etc/shells | grep -q "/bin/bash")" ]]; then
  echo "I RAN"
fi

if [[ "$(type $binroot/yo)" && "$(cat /etc/shells | grep -q "/bin/bash")" ]]; then
  e_header "Adding $binroot/bash to the list of acceptable shells"
fi