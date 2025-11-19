-- ============================
-- mini.cursorword: 高亮游標下的單詞
-- ============================
-- GitHub: https://github.com/echasnovski/mini.cursorword
-- 功能：自動高亮游標所在單詞的所有出現位置

return {
    "echasnovski/mini.cursorword",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mini.cursorword").setup({
            -- ============================
            -- 延遲時間
            -- ============================
            -- 游標停留多久後開始高亮（毫秒）
            delay = 100,
        })

        -- ============================
        -- 在特定檔案類型禁用
        -- ============================
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "lazy",
                "mason",
                "notify",
                "NvimTree",
                "TelescopePrompt",
                "TelescopeResults",
                "terminal",
                "lspinfo",
                "aerial",
            },
            callback = function()
                vim.b.minicursorword_disable = true
            end,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【功能】
        -- 當游標停在一個單詞上時
        -- 檔案中所有相同的單詞都會被高亮
        --
        -- 【使用場景】
        --
        -- 場景 1：查看變數使用位置
        -- ┌────────────────────────────┐
        -- │ const userName = "John";   │
        -- │ console.log(userName);     │ ← 游標在這裡的 userName
        -- │ return userName;           │
        -- └────────────────────────────┘
        -- 所有 userName 都會被高亮 ✨
        --
        -- 場景 2：檢查函式調用
        -- ┌────────────────────────────┐
        -- │ function calculate() {...} │
        -- │ const x = calculate();     │ ← 游標在 calculate
        -- │ const y = calculate();     │
        -- └────────────────────────────┘
        -- 所有 calculate 都會高亮，快速看到所有調用位置
        --
        -- 場景 3：重構前預覽
        -- 準備重新命名變數時
        -- 先把游標移到該變數
        -- 看到所有高亮位置
        -- 確認影響範圍後再執行重新命名
        --
        -- 【自動功能】
        -- - 不需要按任何鍵
        -- - 游標移動到單詞上就自動高亮
        -- - 游標離開就取消高亮
        -- - 延遲 100ms 避免太頻繁閃爍
        --
        -- 【與搜尋的差異】
        --
        -- 搜尋（/pattern）：
        -- - 需要輸入搜尋模式
        -- - 高亮會一直存在直到 :nohl
        -- - 可以用 n/N 跳轉
        --
        -- mini.cursorword：
        -- - 完全自動
        -- - 游標移開就消失
        -- - 只是視覺提示，不能跳轉
        --
        -- 【配合其他功能】
        --
        -- 配合 LSP：
        -- 1. mini.cursorword 快速看到相同名稱
        -- 2. gr（LSP references）看到真正的引用關係
        --
        -- 配合搜尋：
        -- 1. mini.cursorword 確認要搜尋的單詞
        -- 2. * 或 # 搜尋該單詞
        -- 3. n/N 跳轉
        --
        -- 【注意事項】
        -- 1. 只高亮完全相同的單詞
        -- 2. 區分大小寫
        -- 3. 不會高亮註解或字串中的單詞（取決於語法）
        -- 4. 在特殊視窗（如 NvimTree）中自動禁用
        --
        -- 【禁用/啟用】
        -- 臨時禁用當前 buffer：
        -- :lua vim.b.minicursorword_disable = true
        --
        -- 重新啟用：
        -- :lua vim.b.minicursorword_disable = false
        --
        -- 【視覺效果】
        -- 高亮顏色由你的配色方案決定
        -- 通常是底線或背景色變化
    end,
}
