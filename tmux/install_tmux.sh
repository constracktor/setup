#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/.setup/tmux/bin.
# It's assumed that wget and a C/C++ compiler are installed.
set -e
TMUX_VERSION=$1
LIBEVENT_VERSION=2.1.12
NCURSES_VERSION=6.5
# Use local tar files of ncurses and liveent
# wget -O files/libevent-${LIBEVENT_VERSION}-stable.tar.gz https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz 
# wget -O files/ncurses-${NCURSES_VERSION}.tar.gz ftp://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
INSTALL_DIR="$HOME/.setup/tmux"
TMP_DIR="$HOME/.setup/tmux_tmp"
# create our directories
mkdir -p ${INSTALL_DIR} ${TMP_DIR}
cd ${TMP_DIR}
# download tar-file if necessary
case $TMUX_VERSION in
    3.3a)
	echo 'Use local tar-file.'
	;;
    *)
	echo 'Download requested version.'
        wget -O files/tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
	;;
esac
# extract, configure, and compile dependencies
cd files
# libevent
tar xvzf libevent-${LIBEVENT_VERSION}-stable.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=${INSTALL_DIR} --disable-shared --disable-openssl 
make && make install
cd ..
# ncurses
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
./configure --prefix=${INSTALL_DIR}
make && make install
cd ..
# extract, configure, and compile tmux
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I${INSTALL_DIR}/include -I${INSTALL_DIR}/include/ncurses" LDFLAGS="-L${INSTALL_DIR}/lib -L${INSTALL_DIR}/include/ncurses -L${INSTALL_DIR}/include"
CPPFLAGS="-I${TMP_DIR}/include -I${TMP_DIR}/include/ncurses" LDFLAGS="-static -L${TMP_DIR}/include -L${TMP_DIR}/include/ncurses -L${TMP_DIR}/lib" make
cp tmux ${INSTALL_DIR}/bin
# cleanup
rm -rf ../${TMP_DIR}
# copy config
cp config/tmux.conf ${INSTALL_DIR}/.config/.tmux.conf
echo "TMUX installation succesfull."
