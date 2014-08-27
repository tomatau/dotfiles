#!/usr/bin/env bash

declare default_php=5.5.16
declare php_versions=(
  "$default_php"
  5.3.29
)

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

function phpbrew_deps_install() {
  sudo apt-get build-dep php5
  sudo apt-get install -y php5 php5-dev php-pear \
    autoconf automake bison libbz2-dev \
    libxslt1-dev re2c libxml2 libxml2-dev php5-cli
  # +gd +openssl +gettext +mhash +mcrypt +icu
  sudo apt-get install -y libfreetype6 libfreetype6-dev \
    libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev \
    libjpeg8 libgd-dev libgd3 libxpm4
  sudo apt-get install -y libssl-dev openssl
  sudo apt-get install -y gettext libgettextpo-dev libgettextpo0
  sudo apt-get install -y libicu48 libicu-dev
  sudo apt-get install -y libmhash-dev libmhash2
  sudo apt-get install -y libmcrypt-dev libmcrypt4
  # mysql
  sudo apt-get install mysql-server mysql-client \
    libmysqlclient-dev libmysqld-dev
  # postgresql
  sudo apt-get install postgresql postgresql-client \
    postgresql-contrib
}

e_header "Installing Phpbrew"

if [[ ! "$(type -P phpbrew)" ]]; then
  phpbrew_deps_install
  curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
  if [[ -s phpbrew ]]; then
    chmod +x phpbrew
    sudo mv phpbrew /usr/bin/phpbrew
    [[ "$(type -P phpbrew)" ]] && phpbrew init
    [[ -s ~/.phpbrew/bashrc ]] && . ~/.phpbrew/bashrc
  fi
  if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    phpbrew lookup-prefix ubuntu
  else
    phpbrew lookup-prefix homebrew
  fi
  e_success "Installed Phpbrew"
else
  e_header "Phpbew already installed :)"
fi

e_header "Installing Php"
if [[ "$(type -P phpbrew)" ]]; then
  for v in $(to_install "${php_versions[*]}" "$(get_php_versions)"); do
    phpbrew install "${v}" +default
  done
  phpbrew switch "${default_php}"
  if [[ ! "$(type -P composer)" ]]; then
    e_header "Installing Composer"
    phpbrew install-composer
  fi
else
  e_error "Phpbrew was not installed correctly :/"
fi

# if [[ -s ~/.bin/composer.phar ]] && [[ "$(type -P php)" ]]; then
#   curl -sS https://getcomposer.org/installer | php -- --install-dir=~/.bin
# fi