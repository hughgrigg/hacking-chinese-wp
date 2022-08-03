#!/bin/bash

cd /home/vagrant/
rm -rf hacking-chinese-wp
mkdir hacking-chinese-wp && cd hacking-chinese-wp
wget --quiet --output-document latest.tar.gz https://wordpress.org/latest.tar.gz
tar --overwrite -xzvf latest.tar.gz
rm latest.tar.gz
ln -s /home/vagrant/sync/wp-content/themes/hc-2015 wordpress/wp-content/themes/hc-2015

rm -rf wordpress/wp-content/uploads/2022
ln -s /home/vagrant/sync/hc/uploads wordpress/wp-content/uploads
