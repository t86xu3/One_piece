# CLAUDE.md - AI Assistant Context

> This file provides context for AI assistants (Claude, etc.) working with this repository.

## Project Overview

**One_piece** is a personal dotfiles repository for syncing development environment configurations across multiple machines. The goal is: clone once, run install script, get identical setup everywhere.

## Repository Structure

```
One_piece/
├── VERSION              # Current version number (semver)
├── CHANGELOG.md         # Version history and changes
├── CLAUDE.md            # This file (AI context)
├── README.md            # User documentation
├── install.sh           # Main installation script
├── .gitignore           # Git ignore rules
│
├── iterm2/              # iTerm2 terminal configs
│   └── com.googlecode.iterm2.plist
│
├── shell/               # Shell configurations
│   └── .zshrc           # Zsh config (Oh My Zsh + Powerlevel9k)
│
├── mcp/                 # Model Context Protocol configs
│   └── .gitkeep         # (placeholder for future configs)
│
├── skills/              # Custom automation skills
│   └── .gitkeep         # (placeholder for future skills)
│
├── commands/            # Custom CLI commands
│   └── .gitkeep         # (placeholder for future commands)
│
└── fonts/               # Font documentation
    └── .gitkeep         # (Nerd Fonts recommended)
```

## Key Concepts

### Symlink Strategy
Configs are stored in this repo and symlinked to their expected locations:
- `~/.zshrc` → `~/One_piece/shell/.zshrc`
- iTerm2 plist is copied (not symlinked due to app behavior)

### Version Management
- `VERSION` file contains current semver version
- `CHANGELOG.md` documents all changes
- Bump version when adding/modifying configs

## Common Tasks

### Adding a new config file

1. Create the file in appropriate directory
2. Update `install.sh` to handle the new file (symlink or copy)
3. Update `CHANGELOG.md` with the change
4. Bump `VERSION` (PATCH for new file, MINOR for new category)
5. Commit and push

Example:
```bash
# Add new config
cp ~/.config/starship.toml ~/One_piece/shell/

# Update version
echo "1.1.1" > VERSION

# Update changelog (add entry)

# Commit
git add . && git commit -m "Added starship config" && git push
```

### Adding a new category

1. Create new directory: `mkdir ~/One_piece/newcategory`
2. Add `.gitkeep` or actual files
3. Update `install.sh` with installation logic
4. Update `README.md` structure diagram
5. Update this file's structure diagram
6. Bump MINOR version

### Syncing on another machine

```bash
cd ~/One_piece
git pull
./install.sh
```

## Installation Script Behavior

`install.sh` performs these actions:
1. Check macOS
2. Install Homebrew (if missing)
3. Install iTerm2 (if missing)
4. Install Oh My Zsh (if missing)
5. Install Powerlevel9k theme (if missing)
6. Install Hack Nerd Font (if missing)
7. Create symlinks for shell configs
8. Copy iTerm2 preferences

## File Locations Reference

| Config | Repo Location | System Location |
|--------|---------------|-----------------|
| Zsh config | `shell/.zshrc` | `~/.zshrc` (symlink) |
| iTerm2 | `iterm2/com.googlecode.iterm2.plist` | `~/Library/Preferences/` (copy) |
| MCP | `mcp/` | TBD |
| Skills | `skills/` | TBD |
| Commands | `commands/` | TBD |

## Active Skills

### Sync Global Config (IMPORTANT)

**When user adds/modifies GLOBAL configurations (MCP, skills, commands), you MUST:**

1. Complete the requested change first
2. Ask: 「這是全局設定，要同步到 One_piece 倉庫嗎？」
3. If user agrees:
   - Copy/update file to appropriate One_piece directory
   - Update CHANGELOG.md
   - Bump VERSION (PATCH)
   - Commit and push to GitHub

**DO NOT trigger for:**
- Project-specific configs (inside any project folder)
- Files in `.claude/` within a project
- Project-local `mcp.json`

See `skills/sync-global-config.md` for full details.

---

## Guidelines for AI Assistants

1. **Always check VERSION** before making changes
2. **Update CHANGELOG.md** when modifying configs
3. **Bump VERSION** appropriately after changes
4. **Test install.sh** changes carefully
5. **Maintain symlink strategy** - prefer symlinks over copies
6. **Keep README.md updated** if structure changes
7. **Never commit secrets** - check .gitignore covers sensitive files
8. **Follow Active Skills** - especially the Sync Global Config rule

## Owner Info

- GitHub: [t86xu3](https://github.com/t86xu3)
- Repo: [One_piece](https://github.com/t86xu3/One_piece)
