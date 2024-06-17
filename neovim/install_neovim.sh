#!/bin/bash

# Script for installing Neovim on systems where you don't have root access.
# tmux will be installed in $HOME/.setup/tmux/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

NVIM_VERSION=0.9.5

INSTALL_DIR="$HOME/.setup/neovim"
# create our directories
mkdir -p ${INSTALL_DIR} ${TMP_DIR}

# copy config
cp -r config ${INSTALL_DIR}/.config

# download source files for neovim
#TMP_DIR="$HOME/.setup/neovim_tmp"
#cd ${TMP_DIR}
#wget -O nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz

# extract files
tar xvzf nvim-linux64.tar.gz -C $INSTALL_DIR --strip-components 1 

# cleanup
#cd ..
#rm -rf ${TMP_DIR}

echo "$HOME/.setup/neovim/bin/nvim is now available"


