#!/bin/bash
if [[ "$1" == "all" ]]; then
    INSTALL_TMUX=ON
    INSTALL_NEOVIM=ON
elif [[ "$1" == "tmux" ]]; then
    INSTALL_TMUX=ON
elif [[ "$1" == "neovim" ]]; then
    INSTALL_NEOVIM=ON
else
    echo 'Specify: tmux, neovim, or all' >&2
    print_usage_abort
fi
# Versions
TMUX_VERSION=3.3a
NEOVIM_VERSION=0.9.5
# Create own .bashrc.my and add to .bashrc
touch "$HOME/.bashrc.my"
echo '[ -r ~/.bashrc.my ] && . ~/.bashrc.my' >> $HOME/.bashrc
# Path to setup repository
SCRIPT_DIR="$HOME/setup"
# TMUX
if [[ "$INSTALL_TMUX" == "ON" ]]; then
	cd ${SCRIPT_DIR}/tmux && ./install_tmux.sh $TMUX_VERSION
	echo 'alias tmux="${SCRIPT_DIR}/tmux/bin/tmux -f ${SCRIPT_DIR}/tmux/.config/.tmux.conf"' >> $HOME/.bashrc.my
fi
# Neovim
if [[ "$INSTALL_NEOVIM" == "ON" ]]; then
	cd ${SCRIPT_DIR}/neovim && ./install_neovim.sh $NEOVIM_VERSION
	echo 'alias nvim="${SCRIPT_DIR}/neovim/bin/nvim -u ${SCRIPT_DIR}/neovim/.config/init.lua"' >> $HOME/.bashrc.my
fi
