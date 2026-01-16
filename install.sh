#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════╗
# ║                                                                   ║
# ║   ⚓ ONE PIECE - Terminal Environment Setup Script ⚓            ║
# ║                                                                   ║
# ║   "I'm gonna be King of the Pirates!" - Monkey D. Luffy          ║
# ║                                                                   ║
# ╚═══════════════════════════════════════════════════════════════════╝

set -e

# ============================================================
# Usage / Help
# ============================================================
show_help() {
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help, -h       顯示此幫助訊息"
    echo "  --claude-only    只更新 Claude 全局設定 (快速同步)"
    echo "  --shell-only     只更新 shell 設定 (.zshrc)"
    echo "  --iterm-only     只匯入 iTerm2 設定"
    echo "  --sync           同步所有設定檔 (不安裝軟體)"
    echo ""
    echo "Examples:"
    echo "  ./install.sh              # 完整安裝"
    echo "  ./install.sh --claude-only # 快速同步 Claude 設定"
    echo "  ./install.sh --sync       # 同步所有設定檔"
    exit 0
}

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

# Get version
VERSION=$(cat "$SCRIPT_DIR/VERSION" 2>/dev/null || echo "unknown")

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

echo -e "${PURPLE}                      Version: ${VERSION}${NC}\n"
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
# Setup Shell Config (Symlink)
# ============================================================
setup_shell_config() {
    echo -e "\n${BLUE}📄 Setting up shell config (symlink)...${NC}"

    # Check if already symlinked correctly
    if [ -L "$HOME/.zshrc" ] && [ "$(readlink "$HOME/.zshrc")" = "$SCRIPT_DIR/shell/.zshrc" ]; then
        echo -e "${GREEN}✓ Shell config already symlinked${NC}"
        return
    fi

    # Backup existing file (if not a symlink)
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}Backing up existing .zshrc to ${BACKUP_FILE}${NC}"
        mv "$HOME/.zshrc" "$BACKUP_FILE"
    elif [ -L "$HOME/.zshrc" ]; then
        # Remove old symlink
        rm "$HOME/.zshrc"
    fi

    # Create symlink
    ln -s "$SCRIPT_DIR/shell/.zshrc" "$HOME/.zshrc"
    echo -e "${GREEN}✓ Shell config symlinked${NC}"
}

# ============================================================
# Import iTerm2 Settings
# ============================================================
import_iterm2_settings() {
    echo -e "\n${BLUE}⚙️  Importing iTerm2 settings...${NC}"

    # Check if running inside iTerm2
    if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        echo -e "${YELLOW}⚠️  偵測到你正在 iTerm2 內執行此腳本${NC}"
        echo -e "${YELLOW}   為避免終端被關閉，將跳過自動匯入 iTerm2 設定${NC}"
        echo -e "${CYAN}   請在安裝完成後手動執行：${NC}"
        echo -e "${CYAN}   cp ~/One_piece/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/${NC}"
        echo -e "${CYAN}   然後重啟 iTerm2${NC}"
        ITERM_SETTINGS_SKIPPED=true
        return
    fi

    # Close iTerm2 if running (safe because we're not inside it)
    osascript -e 'quit app "iTerm"' 2>/dev/null || true
    sleep 1

    # Copy plist
    cp "$SCRIPT_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"

    # Clear preferences cache
    defaults read com.googlecode.iterm2 &>/dev/null || true

    echo -e "${GREEN}✓ iTerm2 settings imported${NC}"
}

# ============================================================
# Setup Claude Global Config (Symlink)
# ============================================================
setup_claude_config() {
    echo -e "\n${BLUE}🤖 Setting up Claude global config...${NC}"

    # Create .claude directory if not exists
    mkdir -p "$HOME/.claude"

    CLAUDE_MD="$HOME/.claude/CLAUDE.md"
    SOURCE_MD="$SCRIPT_DIR/claude/CLAUDE.md"

    # Check if source exists
    if [ ! -f "$SOURCE_MD" ]; then
        echo -e "${YELLOW}⚠ No Claude config in repo, skipping${NC}"
        return
    fi

    # Check if already symlinked correctly
    if [ -L "$CLAUDE_MD" ] && [ "$(readlink "$CLAUDE_MD")" = "$SOURCE_MD" ]; then
        echo -e "${GREEN}✓ Claude config already symlinked${NC}"
        return
    fi

    # Backup existing file (if not a symlink)
    if [ -f "$CLAUDE_MD" ] && [ ! -L "$CLAUDE_MD" ]; then
        BACKUP_FILE="$CLAUDE_MD.backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}Backing up existing CLAUDE.md to ${BACKUP_FILE}${NC}"
        mv "$CLAUDE_MD" "$BACKUP_FILE"
    elif [ -L "$CLAUDE_MD" ]; then
        rm "$CLAUDE_MD"
    fi

    # Create symlink
    ln -s "$SOURCE_MD" "$CLAUDE_MD"
    echo -e "${GREEN}✓ Claude config symlinked${NC}"
}

# ============================================================
# Quick Sync Functions (for --xxx-only flags)
# ============================================================
sync_claude_only() {
    echo -e "${CYAN}⚓ ONE PIECE - Quick Sync: Claude Config${NC}\n"
    setup_claude_config
    echo -e "\n${GREEN}✓ Claude 設定同步完成！${NC}"
    echo -e "${PURPLE}📁 Config: ${SCRIPT_DIR}/claude/CLAUDE.md${NC}\n"
}

sync_shell_only() {
    echo -e "${CYAN}⚓ ONE PIECE - Quick Sync: Shell Config${NC}\n"
    setup_shell_config
    echo -e "\n${GREEN}✓ Shell 設定同步完成！${NC}"
    echo -e "${YELLOW}請執行 source ~/.zshrc 或重新開啟終端${NC}\n"
}

sync_iterm_only() {
    echo -e "${CYAN}⚓ ONE PIECE - Quick Sync: iTerm2 Settings${NC}\n"
    ITERM_SETTINGS_SKIPPED=false
    import_iterm2_settings
    if [ "$ITERM_SETTINGS_SKIPPED" = false ]; then
        echo -e "\n${GREEN}✓ iTerm2 設定同步完成！請重啟 iTerm2${NC}\n"
    fi
}

sync_all_configs() {
    echo -e "${CYAN}⚓ ONE PIECE - Sync All Configs${NC}\n"
    ITERM_SETTINGS_SKIPPED=false
    setup_shell_config
    setup_claude_config
    import_iterm2_settings
    echo -e "\n${GREEN}✓ 所有設定同步完成！${NC}"
    if [ "$ITERM_SETTINGS_SKIPPED" = true ]; then
        echo -e "${YELLOW}⚠️  iTerm2 設定需手動匯入（見上方指令）${NC}"
    fi
    echo ""
}

# ============================================================
# Main Installation
# ============================================================
main() {
    ITERM_SETTINGS_SKIPPED=false

    check_os
    install_homebrew
    install_iterm2
    install_oh_my_zsh
    install_powerlevel9k
    install_fonts
    setup_shell_config
    setup_claude_config
    import_iterm2_settings  # 放最後，避免關閉終端影響其他設定

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
    if [ "$ITERM_SETTINGS_SKIPPED" = true ]; then
        echo -e "   ${RED}1. 匯入 iTerm2 設定（之前被跳過）：${NC}"
        echo -e "      ${CYAN}cp ~/One_piece/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/${NC}"
        echo -e "   2. 重啟 iTerm2"
    else
        echo -e "   1. Restart iTerm2"
    fi
    echo -e "   2. In iTerm2 Preferences → Profiles → Text → Font"
    echo -e "      Select: ${CYAN}Hack Nerd Font${NC}"
    echo -e "   3. Enjoy your new terminal! 🎉\n"

    echo -e "${PURPLE}📌 Installed version: ${VERSION}${NC}"
    echo -e "${PURPLE}📁 Config location: ${SCRIPT_DIR}${NC}\n"
}

# ============================================================
# Parse Arguments
# ============================================================
case "${1:-}" in
    --help|-h)
        show_help
        ;;
    --claude-only)
        sync_claude_only
        ;;
    --shell-only)
        sync_shell_only
        ;;
    --iterm-only)
        sync_iterm_only
        ;;
    --sync)
        sync_all_configs
        ;;
    "")
        main
        ;;
    *)
        echo -e "${RED}未知選項: $1${NC}"
        echo "使用 --help 查看可用選項"
        exit 1
        ;;
esac
