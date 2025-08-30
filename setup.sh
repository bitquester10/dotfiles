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
    local target_dir="$HOME/.config/tmux"
    local backup_dir="$HOME/.config/tmux.bak"
    local repo_url="git@github.com:bitquester10/tmux-conf.git"

    echo "Setting up tmux configuration..."

    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # If target directory exists, rename it to backup
    if [[ -d "$target_dir" ]]; then
        echo "Existing tmux config found, backing up to $backup_dir"
        # Remove existing backup if it exists
        if [[ -d "$backup_dir" ]]; then
            echo "Removing existing backup at $backup_dir"
            rm -rf "$backup_dir"
        fi
        mv "$target_dir" "$backup_dir"
    fi

    # Clone the tmux-conf repository
    echo "Cloning tmux-conf repository to $target_dir"
    if git clone "$repo_url" "$target_dir"; then
        echo "✓ tmux configuration cloned successfully"

        # Install tmux plugins using TPM
        local tpm_install_script="$HOME/.tmux/plugins/tpm/bin/install_plugins"
        if [[ -f "$tpm_install_script" ]]; then
            echo "Installing tmux plugins..."
            if "$tpm_install_script"; then
                echo "✓ tmux plugins installed successfully"
            else
                echo "Warning: Failed to install tmux plugins, but continuing..."
            fi
        else
            echo "Warning: TPM install script not found at $tpm_install_script"
            echo "Make sure TPM is installed first by running setup_tpm"
        fi

        echo "✓ tmux configuration setup complete"
    else
        echo "Error: Failed to clone tmux-conf repository"
        # If clone failed and we had a backup, restore it
        if [[ -d "$backup_dir" ]]; then
            echo "Restoring backup configuration"
            mv "$backup_dir" "$target_dir"
        fi
        exit 1
    fi
}

# Function to setup mylazyvim configuration
setup_mylazyvim() {
    local nvim_dir="$HOME/.config/nvim"
    local backup_dir="$HOME/.config/nvim.bak"
    local repo_url="git@github.com:bitquester10/mylazyvim.git"

    echo "Setting up mylazyvim configuration..."

    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # If nvim directory exists, rename it to backup
    if [[ -d "$nvim_dir" ]]; then
        echo "Existing nvim config found, backing up to $backup_dir"
        # Remove existing backup if it exists
        if [[ -d "$backup_dir" ]]; then
            echo "Removing existing backup at $backup_dir"
            rm -rf "$backup_dir"
        fi
        mv "$nvim_dir" "$backup_dir"
    fi

    # Clone the mylazyvim repository
    echo "Cloning mylazyvim repository to $nvim_dir"
    if git clone "$repo_url" "$nvim_dir"; then
        echo "✓ mylazyvim configuration setup complete"
    else
        echo "Error: Failed to clone mylazyvim repository"
        # If clone failed and we had a backup, restore it
        if [[ -d "$backup_dir" ]]; then
            echo "Restoring backup configuration"
            mv "$backup_dir" "$nvim_dir"
        fi
        exit 1
    fi
}

# Main execution
echo "Starting dotfiles setup..."
setup_tpm
setup_tmux
setup_mylazyvim
echo "All dotfiles setup complete!"
