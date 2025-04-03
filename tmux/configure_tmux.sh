#!/bin/bash

# Define source and destination paths
SOURCE_FILE="$1/tmux/config/tmux.conf"
TMUX_CONFIG_DIR="$HOME/.config/tmux"

# Ensure the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: $SOURCE_FILE not found!"
    return 1
fi

# Create the tmux config directory if it doesn’t exist
mkdir -p "$TMUX_CONFIG_DIR"

# Copy tmux.conf to the config directory
yes | cp -f "$SOURCE_FILE" "$HOME/.tmux.conf"

# Confirm success
if [ -f "$HOME/.tmux.conf" ]; then
    echo "Successfully copied tmux.conf to $HOME"
else
    echo "Error: Failed to copy tmux.conf"
    return 1
fi
