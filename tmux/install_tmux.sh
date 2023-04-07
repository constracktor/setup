#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/.setup/tmux/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=3.2a
LIBEVENT_VERSION=2.1.12
NCURSES_VERSION=6.2

INSTALL_DIR="$HOME/.setup/tmux"
TMP_DIR="$HOME/.setup/tmux_tmp"
# create our directories
mkdir -p ${INSTALL_DIR} ${TMP_DIR}
cd ${TMP_DIR}

# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz 
wget https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz 
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-${LIBEVENT_VERSION}-stable.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=${INSTALL_DIR} --disable-shared --disable-openssl 
make
make install
cd ..

############
# ncurses  #
############
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
./configure --prefix=${INSTALL_DIR}
make
make install
cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I${INSTALL_DIR}/include -I${INSTALL_DIR}/include/ncurses" LDFLAGS="-L${INSTALL_DIR}/lib -L${INSTALL_DIR}/include/ncurses -L${INSTALL_DIR}/include"
CPPFLAGS="-I${TMP_DIR}/include -I${TMP_DIR}/include/ncurses" LDFLAGS="-static -L${TMP_DIR}/include -L${TMP_DIR}/include/ncurses -L${TMP_DIR}/lib" make
cp tmux ${INSTALL_DIR}/bin
cd ..

# cleanup
rm -rf ${TMP_DIR}

echo "$HOME/.setup/tmux/bin/tmux is now available. You can optionally add $HOME/.setup/tmux/bin to your PATH."
