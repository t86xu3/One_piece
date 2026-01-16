# Update Dotfiles

自動從 GitHub 拉取最新的 One_piece dotfiles 並同步設定。

## 執行步驟

請依序執行以下操作：

1. **檢查 Git 狀態**
   ```bash
   cd ~/One_piece && git fetch origin
   ```

2. **比較版本**
   ```bash
   cd ~/One_piece && echo "本地版本: $(cat VERSION)" && echo "遠端版本: $(git show origin/main:VERSION 2>/dev/null || echo '無法取得')"
   ```

3. **如果有更新，詢問用戶是否要更新**
   - 顯示 `git log HEAD..origin/main --oneline` 的內容讓用戶知道有哪些變更
   - 若用戶同意，執行 `git pull`

4. **執行同步**
   ```bash
   cd ~/One_piece && ./install.sh --sync
   ```

5. **顯示結果**
   - 告知用戶同步完成
   - 顯示目前版本號
