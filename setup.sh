# Source local ~/.bashrc.my
#[ -r ~/.bashrc.my ] && . ~/.bashrc.my
SCRIPT_DIR="$HOME/setup"
INSTALL_DIR="$HOME/.setup"
NEOVIM_VERSION=0.9.5
# Create own bashrc file
mkdir ${INSTALL_DIR}
#touch "$HOME/.bashrc.my"
pwd
# TMUX 
#${SCRIPT_DIR}/tmux/install_tmux.sh
#echo "TMUX installation successful"
#${SCRIPT_DIR}/tmux/configure_tmux.sh
#echo "TMUX configuration successful"
#echo 'alias tmux="$HOME/.setup/tmux/bin/tmux -f $HOME/.setup/tmux/.tmux.conf"' >> $HOME/.bashrc.my
# Neovim
cd ${SCRIPT_DIR}/neovim && ./install_neovim.sh $NEOVIM_VERSION
echo "Neovim installation successful"
#echo 'alias nvim="$HOME/.setup/neovim/bin/nvim -u $HOME/.setup/neovim/.config/init.lua"' >> $HOME/.bashrc.my
