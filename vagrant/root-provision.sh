#!/bin/bash

apt-get update --fix-missing
apt-get install -fy

apt-get install vim git -fy --force-yes
