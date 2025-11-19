-- ============================
-- which-key.nvim: 快捷鍵提示
-- ============================
-- GitHub: https://github.com/folke/which-key.nvim
-- 功能：按下 <Space> 等前綴鍵後，會顯示所有可用的快捷鍵選項
-- 特別適合學習和記憶快捷鍵

return {
    "folke/which-key.nvim",
    event = "VeryLazy",  -- 延遲載入，加快啟動速度
    opts = {
        -- ============================
        -- 基本設定
        -- ============================
        plugins = {
            marks = true,       -- 顯示 marks (m)
            registers = true,   -- 顯示 registers (")
            spelling = {
                enabled = true,   -- 啟用拼寫建議
                suggestions = 20, -- 建議數量
            },
            presets = {
                operators = true,    -- 顯示操作符說明 (d, y, c 等)
                motions = true,      -- 顯示移動說明 (w, e, b 等)
                text_objects = true, -- 顯示文字物件說明 (i, a 等)
                windows = true,      -- 顯示視窗命令 (<C-w>)
                nav = true,          -- 顯示導航說明
                z = true,            -- 顯示折疊相關說明
                g = true,            -- 顯示 g 相關說明
            },
        },

        -- ============================
        -- 彈窗設定
        -- ============================
        win = {
            border = "rounded",     -- 圓角邊框
            padding = { 1, 2 },     -- 內邊距
            title = true,           -- 顯示標題
            title_pos = "center",   -- 標題置中
        },

        -- ============================
        -- 延遲時間（毫秒）
        -- ============================
        delay = 500,  -- 按下快捷鍵後 500ms 才顯示提示（避免干擾）

        -- ============================
        -- 圖示設定
        -- ============================
        icons = {
            breadcrumb = "»",  -- 階層分隔符號
            separator = "➜",   -- 項目分隔符號
            group = "+",       -- 群組符號
        },

        -- ============================
        -- 佈局
        -- ============================
        layout = {
            height = { min = 4, max = 25 }, -- 最小/最大高度
            width = { min = 20, max = 50 }, -- 最小/最大寬度
            spacing = 3,                     -- 欄位間距
            align = "left",                  -- 對齊方式
        },
    },

    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        -- ============================
        -- 註冊快捷鍵說明
        -- ============================
        wk.add({
            -- ============================
            -- 核心編輯功能
            -- ============================
            { "<leader>s", group = "分割視窗" },
            { "<leader>sv", desc = "垂直分割" },
            { "<leader>sh", desc = "水平分割" },
            { "<leader>nh", desc = "清除搜尋高亮" },
            { "<leader>e", desc = "開關檔案樹" },

            -- ============================
            -- Buffer 管理
            -- ============================
            { "<leader>b", group = "Buffer 管理" },
            { "<leader>bn", desc = "新增空白 buffer" },
            { "<leader>bd", desc = "關閉 buffer" },
            { "<leader>bD", desc = "強制關閉 buffer" },
            { "<leader>q", desc = "關閉當前 buffer" },
            { "<leader>Q", desc = "強制關閉 buffer（不儲存）" },
            { "[b", desc = "上一個 buffer" },
            { "]b", desc = "下一個 buffer" },

            -- ============================
            -- Telescope 搜尋
            -- ============================
            { "<leader>f", group = "搜尋 (Find)" },
            { "<leader>ff", desc = "搜尋檔案" },
            { "<leader>fh", desc = "搜尋檔案 (Home)" },
            { "<leader>fF", desc = "搜尋檔案 (根目錄)" },
            { "<leader>fr", desc = "搜尋最近檔案" },
            { "<leader>fs", desc = "搜尋文字內容" },
            { "<leader>fc", desc = "搜尋當前檔案" },
            { "<leader>fb", desc = "搜尋 Buffers" },
            { "<leader>fk", desc = "搜尋快捷鍵" },
            { "<leader>f?", desc = "搜尋說明文件" },

            -- ============================
            -- Git 操作
            -- ============================
            { "<leader>g", group = "Git" },
            { "<leader>gg", desc = "開啟 LazyGit" },
            { "<leader>gf", desc = "LazyGit 當前檔案" },
            { "<leader>gc", desc = "搜尋 Commits" },
            { "<leader>gb", desc = "搜尋分支" },
            { "<leader>gs", desc = "搜尋 Git 狀態" },

            -- Git Hunk 操作（需要在 Git repo 中）
            { "<leader>h", group = "Git Hunk" },
            { "<leader>hs", desc = "Stage 變更", mode = { "n", "v" } },
            { "<leader>hu", desc = "Unstage 變更" },
            { "<leader>hr", desc = "Reset 變更", mode = { "n", "v" } },
            { "<leader>hS", desc = "Stage 整個檔案" },
            { "[c", desc = "上一個 Git 變更" },
            { "]c", desc = "下一個 Git 變更" },

            -- ============================
            -- LSP 功能
            -- ============================
            { "<leader>c", group = "程式碼 (Code)" },
            { "<leader>ca", desc = "程式碼動作", mode = { "n", "v" } },
            { "<leader>d", desc = "顯示錯誤詳情" },
            { "<leader>rn", desc = "重新命名符號" },

            -- LSP 診斷導航
            { "[d", desc = "上一個錯誤" },
            { "]d", desc = "下一個錯誤" },

            -- LSP 跳轉（g 系列）
            { "gd", desc = "跳到定義" },
            { "gD", desc = "跳到聲明" },
            { "gi", desc = "跳到實作" },
            { "gr", desc = "查看引用" },
            { "K", desc = "顯示懸浮文件" },
            { "<C-k>", desc = "函式簽名提示", mode = "n" },

            -- ============================
            -- 代碼地圖與大綱
            -- ============================
            { "<leader>m", group = "代碼地圖 (Map)" },
            { "<leader>mm", desc = "開關代碼地圖" },
            { "<leader>mf", desc = "聚焦代碼地圖" },
            { "<leader>mr", desc = "刷新代碼地圖" },

            { "<leader>a", desc = "開關符號大綱 (Aerial)" },
            { "[a", desc = "上一個符號" },
            { "]a", desc = "下一個符號" },

            -- 縮排範圍導航
            { "[i", desc = "跳到縮排範圍頂部" },
            { "]i", desc = "跳到縮排範圍底部" },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本用法】
        -- 1. 按下 <Space>（或任何前綴鍵）
        -- 2. 等待 500ms（或繼續輸入你知道的快捷鍵）
        -- 3. 會顯示彈窗，列出所有可用的快捷鍵
        -- 4. 看著提示選擇你要的功能
        --
        -- 【常用前綴鍵範例】
        -- - 按 <Space> → 看到所有 leader 快捷鍵（已按功能分組！）
        -- - 按 <Space>f → 看到所有搜尋相關功能
        -- - 按 <Space>g → 看到所有 Git 相關功能
        -- - 按 <Space>b → 看到所有 Buffer 管理功能
        -- - 按 g → 看到所有 g 開頭的命令（gd, gi, gr 等）
        -- - 按 [ 或 ] → 看到所有導航命令
        -- - 按 " → 看到所有可用的 registers
        -- - 按 <C-w> → 看到所有視窗命令
        --
        -- 【快捷鍵分組總覽】
        -- <Space>s*  : 分割視窗
        -- <Space>b*  : Buffer 管理
        -- <Space>f*  : Telescope 搜尋
        -- <Space>g*  : Git 操作
        -- <Space>h*  : Git Hunk 操作
        -- <Space>c*  : 程式碼相關
        --
        -- 【如何添加新快捷鍵】
        -- 在上面的 wk.add() 中添加：
        -- { "快捷鍵", desc = "說明文字" }
        -- { "前綴", group = "群組名稱" }  -- 創建群組
    end,
}
