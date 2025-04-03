#!/bin/bash
# Versions
TMUX_VERSION=3.4
NEOVIM_VERSION=0.10.0
# Create own .bashrc.my and add to .bashrc
touch "$HOME/.bashrc.my"
# Text to add to .bashrc
TEXT_TO_ADD='[ -r ~/.bashrc.my ] && . ~/.bashrc.my'
# Check if the line is already in .bashrc
if ! grep -Fxq "$TEXT_TO_ADD" "$HOME/.bashrc"; then
    echo "$TEXT_TO_ADD" >> "$HOME/.bashrc"
    echo "Added to .bashrc: $TEXT_TO_ADD"
else
    echo "Already exists in .bashrc: $TEXT_TO_ADD"
fi
# Path to setup repository
SCRIPT_DIR="$HOME/setup"

# Install spack in $HOME (if required)
cd ${SCRIPT_DIR}/spack
source install_spack.sh

# TMUX
cd ${SCRIPT_DIR}/tmux
source install_tmux.sh $TMUX_VERSION
source configure_tmux.sh $SCRIPT_DIR
# Neovim
cd ${SCRIPT_DIR}/neovim
source install_neovim.sh $NEOVIM_VERSION
source configure_neovim.sh $SCRIPT_DIR
cd $HOME
