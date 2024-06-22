#!/bin/bash
#
# Script for installing Neovim on systems where you don't have root access.
# Configuration can be changed in "~/.setup/neovim/.config/init.lua"
set -e
NVIM_VERSION=$1
INSTALL_DIR="$HOME/.setup/neovim"
# create install directory
mkdir -p ${INSTALL_DIR}
# copy config
cp -r config ${INSTALL_DIR}/.config
# determine architecture
case $(uname) in
    Linux)
        OS_NAME=linux64
	;;
    Darwin)
	OS_NAME=macos-arm64
	;;
    *)
        echo 'Unknown architecture encountered.' 2>&1
        exit 1
        ;;
esac
FILE_NAME=nvim-$OS_NAME.tar.gz
# download tar-file if necessary
case $NVIM_VERSION in
    0.9.5)
	echo 'Use local tar-file.'
	;;
    *)
	echo 'Download requested version.'
	wget -O files/$FILE_NAME https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/$FILE_NAME
	;;
esac
# extract tar file
tar xvzf files/$FILE_NAME -C $INSTALL_DIR --strip-components 1
echo "Neovim installation successful."
