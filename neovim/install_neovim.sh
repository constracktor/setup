#!/bin/bash
#source $HOME/.bashrc

# Check if a version parameter is provided
if [ -z "$1" ]; then
    echo "No Neovim version specified. Installing the latest version."
    NEOVIM_VERSION=""
else
    NEOVIM_VERSION="@$1"
    echo "Trying to install Neovim version v$1"
fi

# Check if Neovim is already installed with the specified version on the system
if type nvim &> /dev/null; then
    INSTALLED_VERSION=$(nvim --version | head -n 1 | awk '{print $2}' | sed 's/^v//')
    if [ "$INSTALLED_VERSION" == "$1" ]; then
        echo "Neovim version v$1 is already installed on the system."
        return 0
    else
        echo "Neovim is installed but the version doesn't match the specified version (v$1)."
    fi
fi

# Check if Spack is installed
 if ! command -v spack &> /dev/null; then
     echo "Spack is not installed. Neovim cannot be installed"
    return 1
 fi

# Install Neovim with Spack
echo "Installing Neovim$NEOVIM_VERSION with Spack..."
spack install --fresh neovim$NEOVIM_VERSION

# Text to add to .bashrc.my
TEXT_TO_ADD="spack load neovim$NEOVIM_VERSION"
# Check if the line is already in .bashrc.my
if ! grep -Fxq "$TEXT_TO_ADD" "$HOME/.bashrc.my"; then
    echo "$TEXT_TO_ADD" >> "$HOME/.bashrc.my"
    echo "Added to .bashrc.my: $TEXT_TO_ADD"
else
    echo "Already exists in .bashrc.my: $TEXT_TO_ADD"
fi

# Confirm installation
source $HOME/.bashrc
if command -v nvim &> /dev/null; then
    echo "Neovim version v$1 installed successfully!"
else
    echo "Installation failed."
    return 1
fi
