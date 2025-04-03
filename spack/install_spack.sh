#!/bin/bash

# Check if Spack is already installed
if command -v spack &> /dev/null; then
    echo "Spack is already installed."
    return 0
fi

# Define installation directory
SPACK_DIR="$HOME/spack"

# Clone Spack repository fork if not present
if [ ! -d "$SPACK_DIR" ]; then
    echo "Spack not found. Installing..."
    git clone https://github.com/constracktor/spack.git "$SPACK_DIR"
else
    echo "Spack directory already exists. Skipping clone."
fi

# Source Spack environment setup
SPACK_SETUP="$SPACK_DIR/share/spack/setup-env.sh"
if [ -f "$SPACK_SETUP" ]; then
    echo "Adding Spack to shell environment..."
    echo "source $SPACK_SETUP" >> "$HOME/.bashrc.my"
    source "$SPACK_SETUP"
else
    echo "Error: Spack setup script not found!"
    return 1
fi

# Confirm installation
if command -v spack &> /dev/null; then
    echo "Spack installed successfully!"
else
    echo "Installation failed."
    return 1
fi

