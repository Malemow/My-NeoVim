-- ============================
-- mini.tabline: Buffer 標籤列
-- ============================
-- GitHub: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
-- 功能：在頂部顯示所有開啟的 buffer，方便切換和管理

return {
    "echasnovski/mini.tabline",
    version = "*",  -- 使用穩定版本
    config = function()
        require("mini.tabline").setup({
            -- ============================
            -- 顯示設定
            -- ============================
            -- 是否在只有一個標籤時也顯示 tabline
            show_icons = true,  -- 顯示檔案類型圖示（需要 nvim-web-devicons）

            -- ============================
            -- 標籤格式設定
            -- ============================
            -- 自訂每個標籤的顯示方式
            format = nil,  -- 使用預設格式

            -- ============================
            -- 標籤樣式
            -- ============================
            -- 設定標籤如何顯示
            set_vim_settings = true,  -- 自動設定 vim 選項（showtabline=2）

            -- ============================
            -- 標籤列說明
            -- ============================
            -- 頂部會顯示所有開啟的 buffer：
            --
            -- [1 init.lua] [2 options.lua*] [3 keymaps.lua]
            --  │    │         │      │   │      │
            --  │    │         │      │   └──────── 檔案名稱
            --  │    │         │      └──────────── * 表示已修改但未儲存
            --  │    │         └─────────────────── buffer 編號
            --  │    └───────────────────────────── 當前 buffer（會高亮顯示）
            --  └────────────────────────────────── buffer 編號
            --
            -- ============================
            -- 標籤顏色說明
            -- ============================
            -- - 當前 buffer：會用不同顏色高亮（通常是藍色或綠色）
            -- - 已修改的 buffer：檔名後會有 * 標記
            -- - 其他 buffer：正常顏色（灰色）
            --
            -- ============================
            -- 如何使用
            -- ============================
            -- 1. 標籤會自動顯示在頂部
            -- 2. 用 ]b 和 [b 切換 buffer（在 keymaps.lua 中設定）
            -- 3. 可以用 :b <number> 直接跳到特定 buffer
            --    例如：:b 2 會跳到第 2 個 buffer
            -- 4. 用 :bd 關閉當前 buffer
            --
            -- ============================
            -- 常用 buffer 操作
            -- ============================
            -- ]b        : 下一個 buffer（已在 keymaps.lua 設定）
            -- [b        : 上一個 buffer（已在 keymaps.lua 設定）
            -- :b <num>  : 跳到指定 buffer 編號
            -- :bd       : 關閉（刪除）當前 buffer
            -- :bd!      : 強制關閉當前 buffer（即使未儲存）
            -- :buffers  : 列出所有 buffer
            -- :ls       : 列出所有 buffer（同 :buffers）
        })

        -- ============================
        -- 額外的快捷鍵（使用 mini.bufremove）
        -- ============================
        -- 關閉 buffer 但保留視窗佈局
        vim.keymap.set("n", "<leader>bd", function()
            require("mini.bufremove").delete(0, false)
        end, { desc = "關閉當前 buffer" })

        vim.keymap.set("n", "<leader>bD", function()
            require("mini.bufremove").delete(0, true)
        end, { desc = "強制關閉當前 buffer" })
    end,
}
