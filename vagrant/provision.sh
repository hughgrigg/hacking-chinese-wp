#!/bin/zsh

echo "\n\n-----Starting user provisioning-----\n\n"

# Oh My ZSH
if [ ! -d '/home/vagrant/.oh-my-zsh' ]; then
  wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' ~/.zshrc
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

echo "\n\n-----Finished user provisioning-----\n\n"
