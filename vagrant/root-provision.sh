#!/bin/bash

apt-get update --fix-missing

apt-get install zsh vim git -y

wget --quiet https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
chsh -s /bin/zsh vagrant
zsh
