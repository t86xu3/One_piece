# Changelog

All notable changes to this project will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.4.3] - 2026-01-18

### Added
- 新增「技術棧文檔維護」規則：新增技術時須更新 `docs/TECH_STACK.md`

### Changed
- Commit message 格式明確化：`類型: 描述`（如 `功能: 新增登入功能`）

---

## [1.4.2] - 2025-01-18

### Changed
- 改用 `git rev-list --count` 檢查遠端更新（更正規的做法）

---

## [1.4.1] - 2025-01-18

### Added
- 全局 CLAUDE.md 新增「One_piece 版本檢查」規則：每次開啟對話自動檢查遠端更新
- Git commit message 和 PR 說明一律使用中文

---

## [1.4.0] - 2025-01-16

### Added
- 新增 `/update-dotfiles` 全局 command，可快速從 GitHub 同步設定
- 新增 `setup_claude_commands()` 函數，自動 symlink commands 目錄
- install.sh 現在會自動設定 `~/.claude/commands/` 的 symlink

---

## [1.3.2] - 2025-01-16

### Added
- 新增 `--claude-only` 選項：快速同步 Claude 設定
- 新增 `--shell-only` 選項：只更新 shell 設定
- 新增 `--iterm-only` 選項：只匯入 iTerm2 設定
- 新增 `--sync` 選項：同步所有設定檔（不安裝軟體）
- 新增 `--help` 選項：顯示使用說明

### Fixed
- 修復在 iTerm2 內執行 install.sh 會強制關閉終端的問題
- 新增 `$TERM_PROGRAM` 偵測，若在 iTerm2 內執行則跳過自動匯入設定
- 安裝結束時顯示手動匯入 iTerm2 設定的指令

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
