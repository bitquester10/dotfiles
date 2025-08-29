# Dotfiles

Personal configuration files and setup scripts for a consistent development environment.

## Overview

This repository contains my personal dotfiles and configuration files, along with an automated setup script to quickly configure a new machine or update existing configurations.

## Contents

- **tmux/**: Tmux configuration files
  - `tmux.conf` - Custom tmux configuration with plugins and key bindings
- **setup.sh** - Automated setup script for installing and linking configuration files

## Features

### Tmux Configuration
- Custom prefix key (Ctrl-A instead of Ctrl-B)
- Improved key bindings for window and pane management
- Enhanced status bar with custom theme
- Plugin support via TPM (Tmux Plugin Manager)
- Included plugins:
  - `tmux-plugins/tpm` - Plugin manager
  - `tmux-plugins/tmux-sensible` - Sensible defaults
  - `joshmedeski/tmux-nerd-font-window-name` - Nerd font window names
  - `tmux-plugins/tmux-resurrect` - Session persistence

### Setup Script
- Automatic TPM installation
- Safe backup of existing configuration files
- Symlink creation for easy updates
- Idempotent (safe to run multiple times)

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

3. **Reload tmux configuration (if tmux is running):**
   ```bash
   tmux source ~/.tmux.conf
   ```

4. **Install tmux plugins:**
   - Start tmux: `tmux`
   - Press `Ctrl-A + I` (capital I) to install plugins

## What the Setup Script Does

1. **TPM Installation:**
   - Clones TPM to `~/.tmux/plugins/tpm` if not already present
   - Skips installation if TPM is already installed

2. **Tmux Configuration:**
   - Backs up existing `~/.tmux.conf` to `~/.tmux.conf.bak` (if it's a regular file)
   - Creates a symlink from `~/.tmux.conf` to `tmux/tmux.conf` in this repository
   - Handles existing symlinks gracefully

## Manual Setup (Alternative)

If you prefer to set up manually:

1. **Install TPM:**
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

2. **Link tmux configuration:**
   ```bash
   ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
   ```

## Tmux Key Bindings

### Custom Bindings
- **Prefix:** `Ctrl-A` (instead of default Ctrl-B)
- **Split panes:** `|` (horizontal) and `-` (vertical)
- **Navigate windows:** `Alt-H` (previous) and `Alt-L` (next)
- **Reload config:** `Ctrl-A + s`

### Plugin Management (TPM)
- **Install plugins:** `Ctrl-A + I`
- **Update plugins:** `Ctrl-A + U`
- **Uninstall plugins:** `Ctrl-A + Alt-U`

## Requirements

- **tmux** version 1.9 or higher
- **git**
- **bash**

## Adding New Configuration Files

To add support for additional configuration files:

1. Create a new directory for the application (e.g., `vim/`, `zsh/`)
2. Add your configuration files to that directory
3. Update `setup.sh` to include a new setup function
4. Add the function call to the main execution section

Example:
```bash
# Function to setup vim configuration
setup_vim() {
    local source_file="$SCRIPT_DIR/vim/vimrc"
    local target_file="$HOME/.vimrc"
    # ... setup logic similar to setup_tmux
}

# Add to main execution
setup_vim
```

## Troubleshooting

### TPM not working
- Ensure tmux version is 1.9 or higher: `tmux -V`
- Verify TPM is installed: `ls ~/.tmux/plugins/tpm`
- Check tmux configuration syntax: `tmux source ~/.tmux.conf`

### Plugins not loading
- Install plugins manually: `Ctrl-A + I` in tmux
- Check plugin directories: `ls ~/.tmux/plugins/`
- Restart tmux completely

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to fork this repository and adapt it for your own use. If you have suggestions for improvements, please open an issue or submit a pull request.
