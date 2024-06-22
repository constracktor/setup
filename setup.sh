#!/bin/bash

# Versions
NEOVIM_VERSION=0.9.5
# Create own .bashrc.my and add to .bashrc
touch "$HOME/.bashrc.my"
echo '[ -r ~/.bashrc.my ] && . ~/.bashrc.my' >> $HOME/.bashrc
#
SCRIPT_DIR="$HOME/setup"
INSTALL_DIR="$HOME/.setup"
mkdir ${INSTALL_DIR}
pwd
# TMUX 
#${SCRIPT_DIR}/tmux/install_tmux.sh
#echo "TMUX installation successful"
#${SCRIPT_DIR}/tmux/configure_tmux.sh

#echo 'alias tmux="$HOME/.setup/tmux/bin/tmux -f $HOME/.setup/tmux/.tmux.conf"' >> $HOME/.bashrc.my
# Neovim
cd ${SCRIPT_DIR}/neovim && ./install_neovim.sh $NEOVIM_VERSION
echo 'alias nvim="$HOME/.setup/neovim/bin/nvim -u $HOME/.setup/neovim/.config/init.lua"' >> $HOME/.bashrc.my

