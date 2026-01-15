# Skill: Sync Global Config

> 自動詢問是否將全局設定同步到 One_piece 倉庫

## Trigger Conditions

當使用者在 **全局環境** 新增或修改以下項目時，主動詢問是否同步：

- **MCP Server** - 全局 MCP 設定 (`~/.config/claude/` 或類似位置)
- **Skills** - 全局 skill 設定
- **Commands** - 全局自訂指令

## NOT Trigger (不觸發)

- 專案內的 `.claude/` 設定
- 專案內的 `mcp.json`
- 任何存在於專案資料夾內的設定檔

## Behavior

當觸發條件成立時，Claude 應該：

1. 完成使用者要求的設定變更
2. 詢問：「這是全局設定，要同步到 One_piece 倉庫嗎？」
3. 如果使用者同意：
   - 複製/更新檔案到對應的 One_piece 目錄
   - 更新 CHANGELOG.md
   - Bump VERSION (PATCH)
   - 提交並推送到 GitHub

## Directory Mapping

| 全局位置 | One_piece 位置 |
|---------|---------------|
| `~/.config/claude/mcp*.json` | `One_piece/mcp/` |
| Global skills | `One_piece/skills/` |
| Global commands | `One_piece/commands/` |
| `~/.zshrc` | `One_piece/shell/.zshrc` (已 symlink) |

## Example Interaction

```
User: 幫我新增一個 MCP server 設定

Claude: [完成 MCP 設定]

Claude: 這是全局設定，要同步到 One_piece 倉庫嗎？
        - Yes: 同步到 ~/One_piece/mcp/ 並推送
        - No: 只保留在本機

User: Yes

Claude: [複製到 One_piece/mcp/]
        [更新 CHANGELOG.md]
        [Bump VERSION]
        [git commit & push]
        Done! 已同步到 One_piece v1.1.1
```

## Notes

- 此 skill 的目的是確保全局設定不會遺失
- 讓所有裝置都能透過 One_piece 倉庫同步設定
- 專案內設定不同步，因為那是專案專屬的
