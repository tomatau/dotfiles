# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

function get_php_versions() {
    local installed=()
    local v
    for path in "$HOME/.phpbrew/php/"*; do
        if [ `expr "${path##*/}" : "php-[0-9]*\.[0-9]*\.[0-9]*$"` != 0 ]; then
          if [ -d "$path" ]; then
            v="${path##*/}"
            installed=("${installed[@]}" "${v:4}")
          fi
        fi
    done
    echo "${installed[*]}"
}
declare default_php=5.5.16
declare php_versions=(
  "$default_php"
  5.3.29
)

for v in $(to_install "${php_versions[*]}" "$(get_php_versions)"); do
    echo "DO"
    echo "$v"
done