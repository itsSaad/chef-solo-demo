#!/bin/bash

# This runs as root on the server

chef_binary=/usr/local/rbenv/shims/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    yum update -y &&
    yum groupinstall -y development &&
    yum install -y zlib zlib-devel readline readline-devel libyaml-devel libffi-devel openssl-devel

    git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
    echo '# rbenv setup' > /etc/profile.d/rbenv.sh
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    chmod +x /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh

    mkdir -p /usr/local/rbenv/plugins/ruby-build
    git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    source /etc/profile.d/rbenv.sh
    source ~/.bash_profile

    echo "PATHS: " + `env`
    rbenv install 2.3.1
    rbenv global 2.3.1
    rbenv rehash
    gem install --no-rdoc --no-ri chef
fi

# "$chef_binary" -c solo.rb -j solo.json
