#!/bin/bash
source $HOME/.bashrc

# Check if a version parameter is provided
if [ -z "$1" ]; then
    echo "No tmux version specified. Installing the latest version."
    TMUX_VERSION=""
else
    TMUX_VERSION="@$1"
    echo "Trying to install tmux version $1"
fi

# Check if tmux is already installed with the specified version on the system
if type tmux &> /dev/null; then
    INSTALLED_VERSION=$(tmux -V | awk '{print $2}')
    if [ "$INSTALLED_VERSION" == "$1" ]; then
        echo "tmux version $1 is already installed on the system."
        return 0
    else
        echo "tmux is installed but the version doesn't match the specified version ($1)."
    fi
fi

# Check if Spack is installed
if ! command -v spack &> /dev/null; then
    echo "Spack is not installed. tmux cannot be installed."
    return 0
fi

# Install tmux with Spack
echo "Installing tmux$TMUX_VERSION with Spack..."
spack install --fresh tmux$TMUX_VERSION

# Text to add to .bashrc.my
TEXT_TO_ADD="spack load tmux$TMUX_VERSION"
# Check if the line is already in .bashrc.my
if ! grep -Fxq "$TEXT_TO_ADD" "$HOME/.bashrc.my"; then
    echo "$TEXT_TO_ADD" >> "$HOME/.bashrc.my"
    echo "Added to .bashrc.my: $TEXT_TO_ADD"
else
    echo "Already exists in .bashrc.my: $TEXT_TO_ADD"
fi

# Confirm installation
source $HOME/.bashrc
if command -v tmux &> /dev/null; then
    echo "tmux version v$1 installed successfully!"
else
    echo "Installation failed."
    return 1
fi
