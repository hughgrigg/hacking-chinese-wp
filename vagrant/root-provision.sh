#!/bin/bash

echo "\n\n-----Starting root provisioning-----\n\n"

apt-get update --fix-missing

# VIM
apt-get install vim git -y

# ZSH shell
apt-get install zsh
wget --quiet https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
chsh -s /bin/zsh vagrant
zsh

echo "\n\n-----Finished root provisioning-----\n\n"
