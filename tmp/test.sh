# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

function get_python_versions() {
    local installed=()
    for path in "$HOME/.pyenv/versions/"*; do
      if [ -d "$path" ]; then
        installed=("${installed[@]}" "${path##*/}")
      fi
    done
    echo "${installed[*]}"
}
declare default_python=2.7.6

declare python_versions=(
    "$default_python"
    3.4.1
)

for v in $(to_install "${python_versions[*]}" "$(get_python_versions)"); do
    echo "$v"
done