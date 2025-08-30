# Dotfiles

Personal dotfiles setup script for a consistent development environment.

## Overview

This repository contains an automated setup script that configures a development
environment by cloning and installing various configuration repositories and tools.

## Contents

- **setup.sh** - Automated setup script that installs and configures:
  - TPM (Tmux Plugin Manager)
  - Tmux configuration from [tmux-conf repository](https://github.com/bitquester10/tmux-conf)
  - Neovim configuration from [mylazyvim repository](https://github.com/bitquester10/mylazyvim)

## Features

### Setup Script

- **Automatic TPM installation**: Clones and installs Tmux Plugin Manager
- **Tmux configuration**: Clones tmux-conf repository to `~/.config/tmux`
- **Neovim configuration**: Clones mylazyvim repository to `~/.config/nvim`
- **Safe backup handling**: Automatically backs up existing configurations with `.bak` suffix
- **Plugin installation**: Automatically installs tmux plugins after configuration
- **Error handling**: Rollback capability if installations fail
- **Idempotent**: Safe to run multiple times

## Quick Start

1. **Clone the repository:**

   ```bash
   git clone git@github.com:bitquester10/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script:**

   ```bash
   ./setup.sh
   ```

3. **Start using your configured environment:**
   - Tmux configuration will be available at `~/.config/tmux/`
   - Neovim configuration will be available at `~/.config/nvim/`
   - Tmux plugins will be automatically installed

## What the Setup Script Does

1. **TPM Installation:**
   - Clones TPM to `~/.tmux/plugins/tpm` if not already present
   - Skips installation if TPM is already installed

2. **Tmux Configuration:**
   - Backs up existing `~/.config/tmux/` to `~/.config/tmux.bak/` (if it exists)
   - Clones [tmux-conf repository](https://github.com/bitquester10/tmux-conf) to `~/.config/tmux/`
   - Automatically installs tmux plugins using TPM

3. **Neovim Configuration:**
   - Backs up existing `~/.config/nvim/` to `~/.config/nvim.bak/` (if it exists)
   - Clones [mylazyvim repository](https://github.com/bitquester10/mylazyvim) to `~/.config/nvim/`

## Manual Setup (Alternative)

If you prefer to set up manually:

1. **Install TPM:**

   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

2. **Clone tmux configuration:**

   ```bash
   git clone git@github.com:bitquester10/tmux-conf.git ~/.config/tmux
   ```

3. **Clone neovim configuration:**

   ```bash
   git clone git@github.com:bitquester10/mylazyvim.git ~/.config/nvim
   ```

4. **Install tmux plugins:**

   ```bash
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

## Configuration Details

For detailed information about the configurations installed by this script:

- **Tmux Configuration**: See [tmux-conf repository](https://github.com/bitquester10/tmux-conf) for key bindings, plugins, and customizations
- **Neovim Configuration**: See [mylazyvim repository](https://github.com/bitquester10/mylazyvim) for plugins, key mappings, and settings

## Requirements

- **git** - For cloning repositories
- **bash** - For running the setup script
- **tmux** - For using the tmux configuration
- **neovim** - For using the neovim configuration

## Adding New Configuration Repositories

To add support for additional configuration repositories:

1. Create a new setup function in `setup.sh`
2. Follow the pattern of existing functions (backup, clone, error handling)
3. Add the function call to the main execution section

Example:

```bash
# Function to setup zsh configuration
setup_zsh() {
    local target_dir="$HOME/.config/zsh"
    local backup_dir="$HOME/.config/zsh.bak"
    local repo_url="git@github.com:username/zsh-conf.git"

    # ... setup logic similar to setup_tmux
}

# Add to main execution
setup_zsh
```

## Troubleshooting

### Setup script fails

- Ensure you have SSH access to GitHub for the private repositories
- Check that git is installed and configured
- Verify you have write permissions to `~/.config/`

### TPM or tmux plugins not working

- Verify TPM is installed: `ls ~/.tmux/plugins/tpm`
- Check tmux configuration: `tmux source ~/.config/tmux/tmux.conf`
- Manually install plugins: `~/.tmux/plugins/tpm/bin/install_plugins`

### Neovim configuration issues

- Ensure neovim is installed and up to date
- Check the [mylazyvim repository](https://github.com/bitquester10/mylazyvim) for specific requirements

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for details.

## Contributing

Feel free to fork this repository and adapt it for your own use. If you have
suggestions for improvements, please open an issue or submit a pull request.
