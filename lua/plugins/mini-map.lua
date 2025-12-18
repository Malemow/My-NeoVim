-- ============================
-- mini.map: 代碼地圖
-- ============================
-- GitHub: https://github.com/echasnovski/mini.map
-- 功能：在側邊顯示整個檔案的縮略圖，可以快速定位和導航

return {
    "echasnovski/mini.map",
    version = false,
    config = function()
        local map = require("mini.map")

        map.setup({
            -- ============================
            -- 整合器（決定顯示什麼內容）
            -- ============================
            integrations = {
                map.gen_integration.builtin_search(), -- 顯示搜尋結果
                map.gen_integration.diagnostic(),     -- 顯示診斷（錯誤、警告）
                map.gen_integration.gitsigns(),       -- 顯示 Git 變更
            },

            -- ============================
            -- 符號設定
            -- ============================
            symbols = {
                encode = map.gen_encode_symbols.dot("4x2"), -- 使用點陣圖顯示
                scroll_line = "█", -- 滾動條符號
                scroll_view = "┃", -- 視圖範圍符號
            },

            -- ============================
            -- 視窗設定
            -- ============================
            window = {
                focusable = false,              -- 不能聚焦到地圖視窗
                side = "right",                 -- 在右側顯示
                show_integration_count = false, -- 不顯示整合數量
                width = 15,                     -- 寬度（字元數）
                winblend = 25,                  -- 透明度（0-100，0 是不透明）
                zindex = 10,                    -- 層級
            },
        })

        -- ============================
        -- 快捷鍵設定
        -- ============================
        local keymap = vim.keymap

        -- 開關地圖
        keymap.set("n", "<leader>mm", function()
            map.toggle()
        end, { desc = "開關代碼地圖" })

        -- 聚焦到地圖（進入地圖視窗）
        keymap.set("n", "<leader>mf", function()
            map.toggle_focus()
        end, { desc = "聚焦代碼地圖" })

        -- 刷新地圖
        keymap.set("n", "<leader>mr", function()
            map.refresh()
        end, { desc = "刷新代碼地圖" })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本使用】
        -- <Space>mm    : 開關代碼地圖
        -- <Space>mf    : 聚焦到地圖視窗
        -- <Space>mr    : 刷新地圖
        --
        -- 【在地圖視窗中】（需先用 <Space>mf 聚焦）
        -- <CR>         : 跳到對應位置
        -- q            : 關閉地圖
        --
        -- 【顯示內容】
        -- - 整個檔案的縮略圖（用點陣顯示）
        -- - 搜尋結果的位置
        -- - 錯誤/警告的位置
        -- - Git 變更的位置
        -- - 當前視圖範圍（用 ┃ 標示）
        --
        -- 【使用場景】
        -- 1. 查看整個檔案的結構概覽
        -- 2. 快速定位到檔案的特定部分
        -- 3. 查看錯誤/警告在檔案中的分布
        -- 4. 在長檔案中導航
    end,
}
