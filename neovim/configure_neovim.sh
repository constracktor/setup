#!/bin/bash

# Define source and destination paths
SOURCE_FILE="$1/neovim/config/init.lua"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Ensure the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: $SOURCE_FILE not found!"
    return 1
fi

# Create the Neovim config directory if it doesn’t exist
mkdir -p "$NVIM_CONFIG_DIR"

# Copy init.lua to the config directory
yes | cp -f "$SOURCE_FILE" "$NVIM_CONFIG_DIR/init.lua"

# Confirm success
if [ -f "$NVIM_CONFIG_DIR/init.lua" ]; then
    echo "Successfully copied init.lua to $NVIM_CONFIG_DIR"
else
    echo "Error: Failed to copy init.lua"
    return 1
fi
