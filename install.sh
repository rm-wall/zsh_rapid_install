#!/bin/bash

#############################################
# Zsh + Oh My Zsh + Powerlevel10k Installer
# Supports: Ubuntu/Debian and macOS
#############################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
            if [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
                print_info "Detected OS: Ubuntu/Debian"
                return 0
            else
                print_error "Unsupported Linux distribution: $OS"
                print_info "This script supports Ubuntu/Debian and macOS only"
                return 1
            fi
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        print_info "Detected OS: macOS"
        return 0
    else
        print_error "Unsupported OS: $OSTYPE"
        return 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies based on OS
install_dependencies() {
    print_info "Installing dependencies..."

    if [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
        # Ubuntu/Debian
        sudo apt update
        sudo apt install -y git zsh curl wget
    elif [[ "$OS" == "macos" ]]; then
        # macOS
        if ! command_exists brew; then
            print_warning "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install git zsh
    fi

    print_success "Dependencies installed"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_info "Installing Oh My Zsh..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_warning "Oh My Zsh is already installed. Skipping..."
        return 0
    fi

    # Install Oh My Zsh without changing shell automatically
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    print_success "Oh My Zsh installed"
}

# Install zsh plugins
install_zsh_plugins() {
    print_info "Installing zsh plugins..."

    local CUSTOM_PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

    # zsh-autosuggestions
    if [ ! -d "$CUSTOM_PLUGIN_DIR/zsh-autosuggestions" ]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$CUSTOM_PLUGIN_DIR/zsh-autosuggestions"
    else
        print_warning "zsh-autosuggestions already installed"
    fi

    # zsh-syntax-highlighting
    if [ ! -d "$CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting"
    else
        print_warning "zsh-syntax-highlighting already installed"
    fi

    # zsh-completions
    if [ ! -d "$CUSTOM_PLUGIN_DIR/zsh-completions" ]; then
        print_info "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$CUSTOM_PLUGIN_DIR/zsh-completions"
    else
        print_warning "zsh-completions already installed"
    fi

    print_success "Plugins installed"
}

# Configure zsh plugins in .zshrc
configure_plugins() {
    print_info "Configuring plugins in .zshrc..."

    if [ ! -f "$HOME/.zshrc" ]; then
        print_error ".zshrc not found!"
        return 1
    fi

    # Create backup
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

    # Check if plugins are already configured
    if grep -q "zsh-autosuggestions" "$HOME/.zshrc" && \
       grep -q "zsh-syntax-highlighting" "$HOME/.zshrc" && \
       grep -q "zsh-completions" "$HOME/.zshrc"; then
        print_warning "Plugins already configured in .zshrc"
        return 0
    fi

    # Add plugins to .zshrc (compatible with both macOS and Linux)
    if [[ "$OS" == "macos" ]]; then
        # macOS sed syntax
        sed -i '' 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' "$HOME/.zshrc"
    else
        # Linux sed syntax
        sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' "$HOME/.zshrc"
    fi

    print_success "Plugins configured"
}

# Install Powerlevel10k
install_powerlevel10k() {
    print_info "Installing Powerlevel10k theme..."

    local P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    if [ -d "$P10K_DIR" ]; then
        print_warning "Powerlevel10k already installed"
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        print_success "Powerlevel10k installed"
    fi
}

# Configure Powerlevel10k theme
configure_powerlevel10k() {
    print_info "Configuring Powerlevel10k theme..."

    if [ ! -f "$HOME/.zshrc" ]; then
        print_error ".zshrc not found!"
        return 1
    fi

    # Check if already configured
    if grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$HOME/.zshrc"; then
        print_warning "Powerlevel10k already configured"
        return 0
    fi

    # Set theme (compatible with both macOS and Linux)
    if [[ "$OS" == "macos" ]]; then
        sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    else
        sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    fi

    print_success "Powerlevel10k configured"
}

# Change default shell to zsh
change_shell() {
    print_info "Checking default shell..."

    if [[ "$SHELL" == */zsh ]]; then
        print_success "Zsh is already the default shell"
        return 0
    fi

    print_info "Changing default shell to zsh..."

    # Get zsh path
    ZSH_PATH=$(command -v zsh)

    # Check if zsh is in /etc/shells
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        print_warning "Adding $ZSH_PATH to /etc/shells..."
        echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi

    # Change shell
    chsh -s "$ZSH_PATH"
    print_success "Default shell changed to zsh"
}

# Print completion message
print_completion() {
    echo ""
    echo "=========================================="
    print_success "Installation completed successfully!"
    echo "=========================================="
    echo ""
    print_info "Next steps:"
    echo "  1. Restart your terminal or run: exec zsh"
    echo "  2. Powerlevel10k configuration wizard will start automatically"
    echo "  3. Follow the prompts to customize your prompt"
    echo ""
    print_warning "Note: You may need to install the recommended fonts for best experience:"
    echo "  https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
    echo ""
}

# Main installation flow
main() {
    echo ""
    echo "=========================================="
    echo "  Zsh + Oh My Zsh + Powerlevel10k"
    echo "  One-Click Installer"
    echo "=========================================="
    echo ""

    # Detect OS
    if ! detect_os; then
        exit 1
    fi

    # Install dependencies
    install_dependencies

    # Install Oh My Zsh
    install_oh_my_zsh

    # Install plugins
    install_zsh_plugins

    # Configure plugins
    configure_plugins

    # Install Powerlevel10k
    install_powerlevel10k

    # Configure Powerlevel10k
    configure_powerlevel10k

    # Change default shell
    change_shell

    # Print completion message
    print_completion
}

# Run main function
main
