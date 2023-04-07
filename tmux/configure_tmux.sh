#!/bin/bash

# Script for configuring tmux on systems where you don't have root access.
# tmux configuration file will be stored in $HOME/setup/tmux/.

INSTALL_DIR="$HOME/.setup/tmux"

cd ${INSTALL_DIR}
rm -rf plugins
rm -f .tmux.conf
touch .tmux.conf
# write configuration
cat <<EOT >> .tmux.conf  
# Reload config with r
unbind r
bind r source-file ${INSTALL_DIR}/.tmux.conf

# Mouse scrolling and window switching
set -g mouse on

# Splitting terminals using | and -
unbind '"'
unbind %
bind v split-window -h
bind h split-window -v

# Setting second prefix to 'Alt+b'
set-option -g prefix2 M-b
bind-key M-b send-prefix

###############################################################################
# Configure status bar
set-option -g status on
set-option -g status-position bottom
set-option -g status-justify centre
set -g status-bg '#323232'
set -g status-fg '#FFFFFF'

# Configure right bar
set -g status-right-length '100'
set -g status-right '| CPU: #{cpu_percentage} | RAM: #{ram_percentage} | %H:%M #{battery_percentage}#{battery_icon_status} '

# Configure left bar
set-option -g status-left-length '50'
set-option -g status-left ' #(hostname)[#S] |'
###############################################################################

# Pane border colors
set -g pane-border-style fg='#323232'
set -g pane-active-border-style fg='#999999'

# Active window color
set-window-option -g window-status-current-style bg='#999999'

# Set seleted lines colors
set -g mode-style "fg=#000000,bg=#FFFFFF"

# Active window color
set-window-option -g window-status-current-style bg='#999999'

# color of message bar
set -g message-style "fg=#000000,bg=#FFFFFF"


# List of plugins
set -g @tpm_plugins '           \
   tmux-plugins/tpm             \
   tmux-plugins/tmux-sensible   \
   tmux-plugins/tmux-resurrect  \
   tmux-plugins/tmux-cpu	\
   tmux-plugins/tmux-battery	\
'

# set path variables for TMUX 
set-environment -g PATH "${INSTALL_DIR}/bin:/bin:/usr/bin"

# OPTION: install plugins directly in config file
if "test ! -d ${INSTALL_DIR}/plugins/tpm" {
    # install TMUX plugin manager
    run 'git clone https://github.com/tmux-plugins/tpm ${INSTALL_DIR}/plugins/tpm'
    # install other plugins
    run '${INSTALL_DIR}/plugins/tpm/bin/install_plugins'
}
  
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '${INSTALL_DIR}/plugins/tpm/tpm'
EOT

