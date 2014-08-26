#!/usr/bin/env bash

declare default_php="5.5.16"
declare old_stable="5.3.29"

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
  chmod +x phpbrew
  sudo mv phpbrew /usr/bin/phpbrew
  phpbrew init
  . ~/.phpbrew/bashrc
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
  phpbrew install "${old_stable}" +default
  phpbrew install "${default_php}" +default
  phpbrew switch "${default_php}"
  e_header "Installing Composer"
  phpbrew install-composer
else
  e_error "Phpbrew was not installed correctly :/"
fi

# if [[ -s ~/.bin/composer.phar ]] && [[ "$(type -P php)" ]]; then
#   curl -sS https://getcomposer.org/installer | php -- --install-dir=~/.bin
# fi