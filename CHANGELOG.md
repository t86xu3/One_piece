# Changelog

All notable changes to this project will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.3.1] - 2025-01-16

### Changed
- 更新 README.md 結構圖，加入新資料夾
- Changelog 改為連結至 CHANGELOG.md
- 更新 Skills 說明

---

## [1.3.0] - 2025-01-16

### Added
- `claude/` 資料夾 - 全局 Claude 設定
- 全局 CLAUDE.md 規則：
  - 避免幻覺，數據佐證原則
  - 優先使用 Context7 查詢最新文件
  - 預設繁體中文對話

---

## [1.2.0] - 2025-01-16

### Added
- **Skill: sync-global-config** - Auto-prompt to sync global configs to One_piece
- Active Skills section in CLAUDE.md

### Changed
- CLAUDE.md now includes active skill rules for AI assistants

---

## [1.1.0] - 2025-01-16

### Added
- Symlink support in install.sh
- VERSION file for tracking releases
- CHANGELOG.md for change history
- CLAUDE.md for AI assistant context

### Changed
- install.sh now creates symlinks instead of copying files

---

## [1.0.0] - 2025-01-16

### Added
- Initial release
- iTerm2 configuration (com.googlecode.iterm2.plist)
- Zsh configuration with Oh My Zsh + Powerlevel9k
- One-click install.sh script
- Project structure for future configs (mcp, skills, commands, fonts)
- README.md with One Piece theme

---

## Version Guide

```
MAJOR.MINOR.PATCH

MAJOR: Breaking changes (incompatible with previous versions)
MINOR: New features (backwards compatible)
PATCH: Bug fixes (backwards compatible)
```

### When to bump version:

| Change Type | Version Bump | Example |
|-------------|--------------|---------|
| New config category | MINOR | 1.0.0 → 1.1.0 |
| New file in existing category | PATCH | 1.1.0 → 1.1.1 |
| Breaking structure change | MAJOR | 1.1.1 → 2.0.0 |
| Bug fix in scripts | PATCH | 1.1.1 → 1.1.2 |
