# Zsh Rapid Install

One-click installation of Zsh + Oh My Zsh + Powerlevel10k theme and popular plugins.

## Supported Systems

- Ubuntu / Debian
- macOS

## Features

- Automatic OS detection and appropriate package manager usage
- Install Zsh and Oh My Zsh
- Install three best plugins:
  - `zsh-autosuggestions` - Command auto-suggestions
  - `zsh-syntax-highlighting` - Syntax highlighting
  - `zsh-completions` - Additional command completions
- Install and configure Powerlevel10k theme
- Automatic configuration file backup
- Complete error handling

## Quick Start

### Method 1: One-Click Installation (Recommended)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yourusername/zsh_rapid_install/main/install.sh)
```

### Method 2: Clone and Execute

```bash
# Clone the repository
git clone https://github.com/yourusername/zsh_rapid_install.git
cd zsh_rapid_install

# Add execute permissions
chmod +x install.sh

# Run the installation script
./install.sh
```

### Method 3: Manual Command Execution

If you prefer to execute commands manually, refer to the commands in `zsh rapid install.txt`.

## Post-Installation

1. Restart your terminal or run `exec zsh`
2. The Powerlevel10k configuration wizard will start automatically
3. Follow the prompts to customize your command-line style

## Recommended Font

For the best visual experience, install Meslo Nerd Font:

[Download Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

## Backup Files

The script automatically creates backups before modifying configurations:
- `.zshrc.backup.YYYYMMDD_HHMMSS`

## Troubleshooting

### Homebrew Not Installed on macOS

The script will automatically detect and install Homebrew.

### Permission Issues

If you encounter permission issues, ensure you run the script with the correct user identity (do not use root).

### Plugins Already Exist

The script detects already installed components and skips them to avoid duplicate installations.

## Uninstallation

If you need to uninstall, run:

```bash
# Restore backup configuration
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc

# Remove Oh My Zsh
rm -rf ~/.oh-my-zsh

# Restore default shell (bash)
chsh -s /bin/bash
```

## License

MIT