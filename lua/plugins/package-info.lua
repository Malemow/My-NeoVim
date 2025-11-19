-- ============================
-- package-info.nvim: package.json 版本管理
-- ============================
-- GitHub: https://github.com/vuki656/package-info.nvim
-- 功能：在 package.json 中顯示套件的最新版本，並可一鍵更新

return {
    "vuki656/package-info.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    event = "BufRead package.json",  -- 只在開啟 package.json 時載入
    config = function()
        local package_info = require("package-info")

        package_info.setup({
            -- ============================
            -- 顏色設定
            -- ============================
            colors = {
                up_to_date = "#3C4048",  -- 已是最新版本
                outdated = "#d19a66",    -- 有新版本
            },

            -- ============================
            -- 圖示設定
            -- ============================
            icons = {
                enable = true,
                style = {
                    up_to_date = "|  ",  -- 已是最新
                    outdated = "|  ",    -- 有更新
                },
            },

            -- ============================
            -- 自動顯示
            -- ============================
            autostart = true,  -- 開啟 package.json 時自動顯示版本資訊

            -- 隱藏不穩定版本（alpha, beta, rc 等）
            hide_up_to_date = false,  -- 顯示所有套件
            hide_unstable_versions = true,  -- 隱藏不穩定版本

            -- ============================
            -- 套件管理器
            -- ============================
            -- 支援的套件管理器（依照優先順序）
            package_manager = "npm",  -- 可選：npm, yarn, pnpm
        })

        -- ============================
        -- 快捷鍵設定（只在 package.json 中生效）
        -- ============================
        local keymap = vim.keymap

        -- 顯示套件資訊
        keymap.set("n", "<leader>ps", package_info.show, {
            desc = "顯示套件資訊",
            buffer = true,
            silent = true,
        })

        -- 隱藏套件資訊
        keymap.set("n", "<leader>ph", package_info.hide, {
            desc = "隱藏套件資訊",
            buffer = true,
            silent = true,
        })

        -- 切換顯示/隱藏
        keymap.set("n", "<leader>pt", package_info.toggle, {
            desc = "切換套件資訊",
            buffer = true,
            silent = true,
        })

        -- 更新套件到最新版本
        keymap.set("n", "<leader>pu", package_info.update, {
            desc = "更新套件版本",
            buffer = true,
            silent = true,
        })

        -- 刪除套件
        keymap.set("n", "<leader>pd", package_info.delete, {
            desc = "刪除套件",
            buffer = true,
            silent = true,
        })

        -- 安裝新套件
        keymap.set("n", "<leader>pi", package_info.install, {
            desc = "安裝新套件",
            buffer = true,
            silent = true,
        })

        -- 修改套件版本
        keymap.set("n", "<leader>pc", package_info.change_version, {
            desc = "修改套件版本",
            buffer = true,
            silent = true,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【自動功能】
        -- 開啟 package.json 時會自動顯示：
        --   "axios": "^1.4.0"  |  1.6.2
        --                      ↑ 最新版本
        --
        -- 【快捷鍵（只在 package.json 中）】
        -- <Space>pt    : 切換顯示套件資訊
        -- <Space>ps    : 顯示套件資訊
        -- <Space>ph    : 隱藏套件資訊
        -- <Space>pu    : 更新游標下的套件到最新版本
        -- <Space>pd    : 刪除游標下的套件
        -- <Space>pi    : 安裝新套件
        -- <Space>pc    : 修改游標下的套件版本
        --
        -- 【使用流程】
        -- 1. 開啟 package.json
        -- 2. 自動顯示所有套件的最新版本
        -- 3. 將游標移到想更新的套件上
        -- 4. 按 <Space>pu 更新版本號
        -- 5. 儲存檔案後執行 npm install
        --
        -- 【顯示格式】
        -- 綠色/灰色圖示：已是最新版本
        -- 黃色圖示：有新版本可用
        --
        -- 【範例】
        -- {
        --   "dependencies": {
        --     "vue": "^3.3.0"      |  3.4.15  ← 有更新（黃色）
        --     "axios": "^1.6.2"    |  ← 最新（綠色）
        --   }
        -- }
        --
        -- 【注意事項】
        -- 1. 需要網路連線（查詢 npm registry）
        -- 2. 第一次查詢可能需要幾秒鐘
        -- 3. 結果會被快取，提升後續速度
        -- 4. 支援 npm, yarn, pnpm（自動偵測）
        --
        -- 【實用技巧】
        -- 1. 定期開啟 package.json 檢查更新
        -- 2. 用 <Space>pu 批量更新套件
        -- 3. 用 <Space>pc 選擇特定版本（如切換到 beta）
    end,
}
