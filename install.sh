#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════╗
# ║                                                                   ║
# ║   ⚓ ONE PIECE - Terminal Environment Setup Script ⚓            ║
# ║                                                                   ║
# ║   "I'm gonna be King of the Pirates!" - Monkey D. Luffy          ║
# ║                                                                   ║
# ╚═══════════════════════════════════════════════════════════════════╝

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}"
cat << "EOF"
    ⚓ ════════════════════════════════════════════════════════ ⚓

     ██████╗ ███╗   ██╗███████╗    ██████╗ ██╗███████╗ ██████╗███████╗
    ██╔═══██╗████╗  ██║██╔════╝    ██╔══██╗██║██╔════╝██╔════╝██╔════╝
    ██║   ██║██╔██╗ ██║█████╗      ██████╔╝██║█████╗  ██║     █████╗
    ██║   ██║██║╚██╗██║██╔══╝      ██╔═══╝ ██║██╔══╝  ██║     ██╔══╝
    ╚██████╔╝██║ ╚████║███████╗    ██║     ██║███████╗╚██████╗███████╗
     ╚═════╝ ╚═╝  ╚═══╝╚══════╝    ╚═╝     ╚═╝╚══════╝ ╚═════╝╚══════╝

    ⚓ ════════════════════════════════════════════════════════ ⚓
EOF
echo -e "${NC}"

echo -e "${YELLOW}🏴‍☠️ Setting sail for the Grand Line...${NC}\n"

# ============================================================
# Check OS
# ============================================================
check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo -e "${RED}❌ This script is designed for macOS only!${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ macOS detected${NC}"
}

# ============================================================
# Install Homebrew
# ============================================================
install_homebrew() {
    echo -e "\n${BLUE}🍺 Checking Homebrew...${NC}"
    if ! command -v brew &> /dev/null; then
        echo -e "${YELLOW}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo -e "${GREEN}✓ Homebrew already installed${NC}"
    fi
}

# ============================================================
# Install iTerm2
# ============================================================
install_iterm2() {
    echo -e "\n${BLUE}💻 Checking iTerm2...${NC}"
    if ! brew list --cask iterm2 &> /dev/null; then
        echo -e "${YELLOW}Installing iTerm2...${NC}"
        brew install --cask iterm2
    else
        echo -e "${GREEN}✓ iTerm2 already installed${NC}"
    fi
}

# ============================================================
# Install Oh My Zsh
# ============================================================
install_oh_my_zsh() {
    echo -e "\n${BLUE}🐚 Checking Oh My Zsh...${NC}"
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo -e "${GREEN}✓ Oh My Zsh already installed${NC}"
    fi
}

# ============================================================
# Install Powerlevel9k Theme
# ============================================================
install_powerlevel9k() {
    echo -e "\n${BLUE}🎨 Checking Powerlevel9k theme...${NC}"
    THEME_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel9k"
    if [ ! -d "$THEME_DIR" ]; then
        echo -e "${YELLOW}Installing Powerlevel9k...${NC}"
        git clone https://github.com/Powerlevel9k/powerlevel9k.git "$THEME_DIR"
    else
        echo -e "${GREEN}✓ Powerlevel9k already installed${NC}"
    fi
}

# ============================================================
# Install Nerd Fonts
# ============================================================
install_fonts() {
    echo -e "\n${BLUE}🔤 Checking Nerd Fonts...${NC}"
    if ! brew list --cask font-hack-nerd-font &> /dev/null; then
        echo -e "${YELLOW}Installing Nerd Fonts (Hack)...${NC}"
        brew tap homebrew/cask-fonts 2>/dev/null || true
        brew install --cask font-hack-nerd-font
    else
        echo -e "${GREEN}✓ Nerd Fonts already installed${NC}"
    fi
}

# ============================================================
# Copy Shell Config
# ============================================================
copy_shell_config() {
    echo -e "\n${BLUE}📄 Setting up shell config...${NC}"
    if [ -f "$HOME/.zshrc" ]; then
        echo -e "${YELLOW}Backing up existing .zshrc to .zshrc.backup${NC}"
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi
    cp "$SCRIPT_DIR/shell/.zshrc" "$HOME/.zshrc"
    echo -e "${GREEN}✓ Shell config installed${NC}"
}

# ============================================================
# Import iTerm2 Settings
# ============================================================
import_iterm2_settings() {
    echo -e "\n${BLUE}⚙️  Importing iTerm2 settings...${NC}"

    # Close iTerm2 if running
    osascript -e 'quit app "iTerm"' 2>/dev/null || true
    sleep 1

    # Copy plist
    cp "$SCRIPT_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"

    # Clear preferences cache
    defaults read com.googlecode.iterm2 &>/dev/null || true

    echo -e "${GREEN}✓ iTerm2 settings imported${NC}"
}

# ============================================================
# Main Installation
# ============================================================
main() {
    check_os
    install_homebrew
    install_iterm2
    install_oh_my_zsh
    install_powerlevel9k
    install_fonts
    copy_shell_config
    import_iterm2_settings

    echo -e "\n${CYAN}"
    cat << "EOF"
    ⚓ ════════════════════════════════════════════════════════ ⚓

       🏴‍☠️  INSTALLATION COMPLETE!  🏴‍☠️

       "The sea is vast. There are definitely people
        that are even stronger than us somewhere out there."
                                        - Roronoa Zoro

    ⚓ ════════════════════════════════════════════════════════ ⚓
EOF
    echo -e "${NC}"

    echo -e "${YELLOW}📋 Post-installation steps:${NC}"
    echo -e "   1. Restart iTerm2"
    echo -e "   2. In iTerm2 Preferences → Profiles → Text → Font"
    echo -e "      Select: ${CYAN}Hack Nerd Font${NC}"
    echo -e "   3. Enjoy your new terminal! 🎉\n"
}

# Run main function
main "$@"
