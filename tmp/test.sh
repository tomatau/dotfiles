# Whilst building scripts, use this file for convenient testin


PWATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT=$( dirname $PWATH )

source "$PARENT/bin/dotfiles_functions.sh"

function get_ruby_versions() {
    local installed=()
    local v
    for path in "$HOME/.rbenv/versions/"*; do
        if [ `expr "${path##*/}" : "[0-9]*\.[0-9]*\.[0-9]*$"` != 0 ]; then
          if [ -d "$path" ]; then
            v="${path##*/}"
            installed=("${installed[@]}" "${v}")
          fi
        fi
    done
    echo "${installed[*]}"
}
declare default_ruby=2.1.2
declare ruby_versions=(
  "$default_ruby"
)
for v in $(to_install "${ruby_versions[*]}" "$(get_ruby_versions)"); do
    echo "DO"
    echo "$v"
done