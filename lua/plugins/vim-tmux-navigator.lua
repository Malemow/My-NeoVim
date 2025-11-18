-- ============================
-- vim-tmux-navigator: 窗口切換導航
-- ============================
-- GitHub: https://github.com/christoomey/vim-tmux-navigator
-- 功能：在 Neovim 分割窗口之間（包括 nvim-tree）無縫切換
--       如果有使用 tmux，也可以在 tmux 面板之間切換

return {
    "christoomey/vim-tmux-navigator",
    lazy = false,  -- 不要延遲載入，確保快捷鍵立即可用
    config = function()
        -- ============================
        -- 預設快捷鍵
        -- ============================
        -- <C-h> : 切換到左側窗口（或 nvim-tree）
        -- <C-j> : 切換到下方窗口
        -- <C-k> : 切換到上方窗口
        -- <C-l> : 切換到右側窗口
        -- <C-\> : 切換到上一個窗口

        -- ============================
        -- 使用說明
        -- ============================
        -- 1. 開啟 nvim-tree（按 <Space>e）
        -- 2. 按 <C-l> 切換到右側編輯區
        -- 3. 按 <C-h> 切換回 nvim-tree
        -- 4. 如果有多個分割窗口，用 <C-h/j/k/l> 在它們之間移動
        --
        -- 範例工作流程：
        -- - nvim-tree 開啟 → <C-l> → 編輯檔案
        -- - 編輯中 → <C-h> → 回到 nvim-tree 選擇其他檔案
        -- - 水平分窗後 → <C-j>/<C-k> → 在上下窗口切換

        -- ============================
        -- 禁用預設按鍵映射（如果你想自訂快捷鍵）
        -- ============================
        -- vim.g.tmux_navigator_no_mappings = 1

        -- ============================
        -- 自訂快捷鍵範例（如果啟用上面的選項）
        -- ============================
        -- vim.keymap.set("n", "<A-h>", ":<C-U>TmuxNavigateLeft<CR>", { silent = true })
        -- vim.keymap.set("n", "<A-j>", ":<C-U>TmuxNavigateDown<CR>", { silent = true })
        -- vim.keymap.set("n", "<A-k>", ":<C-U>TmuxNavigateUp<CR>", { silent = true })
        -- vim.keymap.set("n", "<A-l>", ":<C-U>TmuxNavigateRight<CR>", { silent = true })

        -- ============================
        -- 與 nvim-tree 整合
        -- ============================
        -- nvim-tree 已經內建支援 vim-tmux-navigator
        -- 不需要額外配置，開箱即用！
    end,
}
