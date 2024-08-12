#!/bin/bash

set -e
# Install node and npm via nvm - https://github.com/creationix/nvm

# Define versions
INSTALL_NODE_VER=18
INSTALL_NVM_VER=0.40.0
INSTALL_YARN_VER=1.7.0

echo "==> Ensuring .bashrc exists and is writable"
touch ~/.bashrc

echo "==> Installing node version manager (NVM). Version $INSTALL_NVM_VER"
# Removed if already installed
rm -rf ~/.nvm
# Unset exported variable
export NVM_DIR=

# Install nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$INSTALL_NVM_VER/install.sh | bash
# Make nvm command available to terminal
source ~/.nvm/nvm.sh

echo "==> Installing node js version $INSTALL_NODE_VER"
nvm install $INSTALL_NODE_VER

echo "==> Make this version system default"
nvm alias default $INSTALL_NODE_VER
nvm use default


echo "==> Checking for versions"
nvm --version
node --version
npm --version

nvm cache clear
