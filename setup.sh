# Source local ~/.bashrc.my
#[ -r ~/.bashrc.my ] && . ~/.bashrc.my
SCRIPT_DIR="$HOME/setup"
INSTALL_DIR="$HOME/.setup"

# Create own bashrc file
mkdir "${INSTALL_DIR}"
touch "$HOME/.bashrc.my"
pwd
# TMUX 
${SCRIPT_DIR}/tmux/install_tmux.sh
echo "TMUX installation successful"
${SCRIPT_DIR}/tmux/configure_tmux.sh
echo "TMUX configuration successful"
echo 'alias tmux="$HOME/.setup/tmux/bin/tmux -f $HOME/.setup/tmux/.tmux.conf"' >> $HOME/.bashrc.my
