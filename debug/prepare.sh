#!/bin/sh

set -eux

sudo apt-get update
sudo apt-get install -y openjdk-8-jdk make

sudo apt-get install -y nodejs npm
sudo npm cache clean
sudo npm install n -g
sudo n v9
sudo ln -sf /usr/local/bin/node /usr/bin/node
sudo apt-get purge -y nodejs npm
sudo npm i yarn -g
sudo chown -R ubuntu ~/.config

git clone https://github.com/mizzy/halyard.git
