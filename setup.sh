#!/bin/bash

# Setup script for dotfiles
# This script creates symlinks for configuration files

set -e  # Exit on any error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up dotfiles from: $SCRIPT_DIR"

# Function to setup TPM (Tmux Plugin Manager)
setup_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    echo "Setting up TPM (Tmux Plugin Manager)..."

    # Check if TPM is already installed
    if [[ -d "$tpm_dir" ]]; then
        echo "TPM already installed at $tpm_dir, skipping..."
        return 0
    fi

    # Create the plugins directory if it doesn't exist
    mkdir -p "$HOME/.tmux/plugins"

    # Clone TPM
    echo "Cloning TPM to $tpm_dir"
    if git clone https://github.com/tmux-plugins/tpm "$tpm_dir"; then
        echo "✓ TPM installation complete"
    else
        echo "Error: Failed to clone TPM repository"
        exit 1
    fi
}

# Function to setup tmux configuration
setup_tmux() {
    local source_file="$SCRIPT_DIR/tmux/tmux.conf"
    local target_file="$HOME/.tmux.conf"
    local backup_file="$HOME/.tmux.conf.bak"

    echo "Setting up tmux configuration..."

    # Check if source file exists
    if [[ ! -f "$source_file" ]]; then
        echo "Error: Source file $source_file does not exist!"
        exit 1
    fi

    # If target exists and is a regular file (not a symlink), back it up
    if [[ -f "$target_file" && ! -L "$target_file" ]]; then
        echo "Backing up existing $target_file to $backup_file"
        mv "$target_file" "$backup_file"
    elif [[ -L "$target_file" ]]; then
        echo "Removing existing symlink $target_file"
        rm "$target_file"
    fi

    # Create the symlink
    echo "Creating symlink: $target_file -> $source_file"
    ln -s "$source_file" "$target_file"

    echo "✓ tmux configuration setup complete"
}

# Main execution
echo "Starting dotfiles setup..."
setup_tpm
setup_tmux
echo "All dotfiles setup complete!"
