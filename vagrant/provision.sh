#!/bin/bash

# bash it
if [ ! -d '/home/vagrant/.bash_it' ]; then
  git clone https://github.com/Bash-it/bash-it.git ~/.bash_it
  ~/.bash_it/install.sh
  sed -i "s/BASH_IT_THEME='bobby'/BASH_IT_THEME='nwinkler'/g" ~/.bashrc
fi

cd /home/vagrant/
rm -rf hacking-chinese-wp
mkdir hacking-chinese-wp && cd hacking-chinese-wp
wget --quiet --output-document latest.tar.gz https://wordpress.org/latest.tar.gz
tar --overwrite -xzvf latest.tar.gz
rm latest.tar.gz
ln -s /home/vagrant/sync/wp-content/themes/hc-2015 wordpress/wp-content/themes/hc-2015

rm -rf wordpress/wp-content/uploads/2015
ln -s /home/vagrant/sync/hc/uploads wordpress/wp-content/uploads
