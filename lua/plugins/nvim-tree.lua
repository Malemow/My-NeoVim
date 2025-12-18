-- ============================
-- nvim-tree: 檔案瀏覽器
-- ============================
-- GitHub: https://github.com/nvim-tree/nvim-tree.lua
-- 功能：在側邊欄顯示檔案樹狀結構，方便瀏覽和操作檔案

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",  -- 檔案圖示（讓檔案類型更清楚）
    },
    config = function()
        -- 取得 nvim-tree 模組
        local nvim_tree = require("nvim-tree")

        -- 建議：在載入 nvim-tree 前先關閉 netrw（Neovim 內建的檔案瀏覽器）
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- 配置 nvim-tree
        nvim_tree.setup({
            view = {
                width = 35,  -- 側邊欄寬度（字元數）
                relativenumber = false,  -- 不顯示相對行號
            },
            renderer = {
                indent_markers = {
                    enable = true,  -- 顯示縮排線，更容易看清檔案層級
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,  -- 開啟檔案時不顯示視窗選擇器（簡化操作）
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },  -- 隱藏特定檔案（macOS 的 .DS_Store）
            },
            git = {
                ignore = false,  -- 顯示 .gitignore 中的檔案（預設會隱藏）
            },
        })

        -- ============================
        -- 快捷鍵設定
        -- ============================
        local keymap = vim.keymap
        keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "切換檔案樹" })

        -- ============================
        -- 常用快捷鍵說明（在 nvim-tree 視窗中使用）
        -- ============================
        -- a      : 新增檔案/資料夾（路徑結尾加 / 表示資料夾）
        -- d      : 刪除檔案/資料夾
        -- r      : 重新命名
        -- x      : 剪下（之後按 p 貼上）
        -- c      : 複製（之後按 p 貼上）
        -- p      : 貼上
        -- y      : 複製檔名
        -- Y      : 複製相對路徑
        -- gy     : 複製絕對路徑
        -- <CR>   : 開啟檔案或展開/收合資料夾
        -- o      : 開啟檔案或展開/收合資料夾（同 <CR>）
        -- <Tab>  : 預覽檔案（不離開 nvim-tree）
        -- I      : 顯示/隱藏被 gitignore 的檔案
        -- H      : 顯示/隱藏隱藏檔案（如 .env）
        -- R      : 重新整理檔案樹
        -- q      : 關閉 nvim-tree
        -- g?     : 顯示所有快捷鍵說明
    end,
}
