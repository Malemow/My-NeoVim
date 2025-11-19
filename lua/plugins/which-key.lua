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
            -- Buffer 管理 (bufferline)
            -- ============================
            { "<leader>b", group = "Buffer 管理" },
            { "<leader>bn", desc = "新增空白 buffer" },
            { "<leader>bd", desc = "關閉 buffer" },
            { "<leader>bD", desc = "強制關閉 buffer" },
            { "<leader>bp", desc = "選擇 Buffer" },
            { "<leader>bc", desc = "選擇並關閉 Buffer" },
            { "<leader>bh", desc = "關閉左側所有標籤" },
            { "<leader>bl", desc = "關閉右側所有標籤" },
            { "<leader>bo", desc = "關閉其他所有標籤" },
            { "<leader>bP", desc = "釘選/取消釘選 Buffer" },
            { "<leader>bm", desc = "向右移動標籤" },
            { "<leader>bM", desc = "向左移動標籤" },
            { "<leader>bg", desc = "切換分組" },
            { "<leader>q", desc = "關閉當前 buffer" },
            { "<leader>Q", desc = "強制關閉 buffer（不儲存）" },
            { "[b", desc = "上一個 buffer" },
            { "]b", desc = "下一個 buffer" },

            -- 數字快速跳轉
            { "<leader>1", desc = "跳到標籤 1" },
            { "<leader>2", desc = "跳到標籤 2" },
            { "<leader>3", desc = "跳到標籤 3" },
            { "<leader>4", desc = "跳到標籤 4" },
            { "<leader>5", desc = "跳到標籤 5" },
            { "<leader>6", desc = "跳到標籤 6" },
            { "<leader>7", desc = "跳到標籤 7" },
            { "<leader>8", desc = "跳到標籤 8" },
            { "<leader>9", desc = "跳到標籤 9" },
            { "<leader>$", desc = "跳到最後一個標籤" },

            -- ============================
            -- 搜尋與替換
            -- ============================
            { "<leader>f", group = "搜尋 (Find)" },
            { "<leader>ff", desc = "搜尋檔案" },
            { "<leader>fe", desc = "檔案瀏覽器 (可輸入 ..)" },
            { "<leader>fE", desc = "檔案瀏覽器 (根目錄)" },
            { "<leader>fh", desc = "搜尋檔案 (Home)" },
            { "<leader>fF", desc = "搜尋檔案 (根目錄)" },
            { "<leader>fr", desc = "搜尋最近檔案" },
            { "<leader>fs", desc = "搜尋文字內容" },
            { "<leader>fc", desc = "搜尋當前檔案" },
            { "<leader>fb", desc = "搜尋 Buffers" },
            { "<leader>fk", desc = "搜尋快捷鍵" },
            { "<leader>f?", desc = "搜尋說明文件" },
            { "<leader>ft", desc = "搜尋 TODO 註解" },
            { "<leader>fT", desc = "搜尋 TODO/FIX/FIXME" },

            -- Grug-far 全局替換
            { "<leader>R", desc = "打開 Grug-far（全局搜尋替換）" },
            { "<leader>r", group = "替換 (Replace)" },
            { "<leader>rw", desc = "替換當前單詞（Grug-far）" },
            { "<leader>rw", desc = "替換選取內容（Grug-far）", mode = "v" },
            { "<leader>rf", desc = "在當前文件替換（Grug-far）" },

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
            { "<leader>cd", desc = "顯示錯誤詳情" },
            { "<leader>rn", desc = "重新命名符號" },

            -- 文檔註解生成 (Neogen)
            { "<leader>cg", group = "生成註解" },
            { "<leader>cgf", desc = "生成函數註解" },
            { "<leader>cgc", desc = "生成類別註解" },
            { "<leader>cgt", desc = "生成類型註解" },
            { "<leader>cgF", desc = "生成文件註解" },

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

            -- 縮排範圍導航（mini.indentscope）
            { "[i", desc = "跳到縮排範圍頂部 / 上一個縮排變化" },
            { "]i", desc = "跳到縮排範圍底部 / 下一個縮排變化" },

            -- ============================
            -- mini.bracketed 導航（[] 系統）
            -- ============================
            -- 檔案和視窗
            { "[f", desc = "上一個檔案" },
            { "]f", desc = "下一個檔案" },
            { "[w", desc = "上一個視窗" },
            { "]w", desc = "下一個視窗" },

            -- 列表導航
            { "[q", desc = "上一個 quickfix" },
            { "]q", desc = "下一個 quickfix" },
            { "[l", desc = "上一個 location list" },
            { "]l", desc = "下一個 location list" },

            -- 歷史導航
            { "[j", desc = "上一個跳轉位置" },
            { "]j", desc = "下一個跳轉位置" },
            { "[u", desc = "上一個 undo 狀態" },
            { "]u", desc = "下一個 undo 狀態（redo）" },
            { "[y", desc = "上一個 yank" },
            { "]y", desc = "下一個 yank" },

            -- 程式碼導航
            { "[o", desc = "上一個註解/舊檔案" },
            { "]o", desc = "下一個註解/舊檔案" },

            -- TODO 註解導航
            { "[t", desc = "上一個 TODO 註解" },
            { "]t", desc = "下一個 TODO 註解" },

            -- ============================
            -- 快速跳轉與移動
            -- ============================
            { "s", desc = "跳轉到行首 (Jump2d)", mode = "n" },
            { "S", desc = "跳轉到單詞 (Jump2d)", mode = "n" },

            -- mini.move（Alt+hjkl）
            { "<A-h>", desc = "向左移動/減少縮排", mode = { "n", "v" } },
            { "<A-j>", desc = "向下移動", mode = { "n", "v" } },
            { "<A-k>", desc = "向上移動", mode = { "n", "v" } },
            { "<A-l>", desc = "向右移動/增加縮排", mode = { "n", "v" } },

            -- ============================
            -- 標記管理 (marks.nvim)
            -- ============================
            { "m", group = "標記 (Marks)" },
            { "m,", desc = "列出所有標記" },
            { "m;", desc = "列出當前 buffer 的標記" },
            { "m]", desc = "跳到下一個標記" },
            { "m[", desc = "跳到上一個標記" },
            { "m:", desc = "預覽標記" },
            { "dm", group = "刪除標記" },
            { "dm-", desc = "刪除當前行的標記" },
            { "dm=", desc = "刪除當前 buffer 所有標記" },

            -- ============================
            -- Noice 命令
            -- ============================
            { "<leader>n", group = "Noice (通知/訊息)" },
            { "<leader>nh", desc = "顯示 Noice 歷史" },
            { "<leader>nd", desc = "關閉所有通知" },
            { "<leader>ne", desc = "顯示錯誤" },

            -- ============================
            -- Trouble 診斷面板
            -- ============================
            { "<leader>x", group = "Trouble 診斷" },
            { "<leader>xx", desc = "診斷列表 (Trouble)" },
            { "<leader>xX", desc = "當前文件診斷 (Trouble)" },
            { "<leader>xs", desc = "符號大綱 (Trouble)" },
            { "<leader>xl", desc = "LSP 定義/引用 (Trouble)" },
            { "<leader>xL", desc = "Location List (Trouble)" },
            { "<leader>xQ", desc = "Quickfix List (Trouble)" },
            { "<leader>xt", desc = "TODO 列表 (Trouble)" },
            { "<leader>xT", desc = "TODO/FIX/FIXME (Trouble)" },

            -- Trouble 導航
            { "[x", desc = "上一個問題 (Trouble)" },
            { "]x", desc = "下一個問題 (Trouble)" },

            -- ============================
            -- Package 管理（package.json 中）
            -- ============================
            { "<leader>p", group = "Package 管理" },
            { "<leader>pt", desc = "切換套件資訊" },
            { "<leader>ps", desc = "顯示套件資訊" },
            { "<leader>ph", desc = "隱藏套件資訊" },
            { "<leader>pu", desc = "更新套件版本" },
            { "<leader>pd", desc = "刪除套件" },
            { "<leader>pi", desc = "安裝新套件" },
            { "<leader>pc", desc = "修改套件版本" },

            -- ============================
            -- 調試器 (nvim-dap)
            -- ============================
            { "<leader>d", group = "調試 (Debug)" },
            { "<leader>db", desc = "切換中斷點" },
            { "<leader>dB", desc = "條件中斷點" },
            { "<leader>dc", desc = "繼續執行/開始調試" },
            { "<leader>di", desc = "步入" },
            { "<leader>do", desc = "步過" },
            { "<leader>dO", desc = "步出" },
            { "<leader>dr", desc = "切換 REPL" },
            { "<leader>dl", desc = "重新執行上次調試" },
            { "<leader>dt", desc = "終止調試" },
            { "<leader>du", desc = "切換調試 UI" },
            { "<leader>de", desc = "評估表達式", mode = { "n", "v" } },

            -- ============================
            -- 終端管理 (toggleterm)
            -- ============================
            { "<leader>t", group = "終端 (Terminal)" },
            { "<leader>tt", desc = "浮動終端" },
            { "<leader>th", desc = "水平終端" },
            { "<leader>tv", desc = "垂直終端" },
            { "<leader>tg", desc = "Lazygit 終端" },
            { "<leader>tn", desc = "Node 終端" },
            { "<leader>tp", desc = "Python 終端" },
            { "<C-\\>", desc = "切換終端" },

            -- ============================
            -- 會話管理 (mini.sessions)
            -- ============================
            { "<leader>S", group = "會話 (Session)" },
            { "<leader>Ss", desc = "恢復當前目錄會話" },
            { "<leader>Sw", desc = "保存當前目錄會話" },
            { "<leader>Sl", desc = "選擇並載入會話" },
            { "<leader>Sd", desc = "刪除會話" },
            { "<leader>Sn", desc = "保存命名會話" },

            -- ============================
            -- AI 助手 (Claude Code)
            -- ============================
            { "<leader>C", group = "AI 助手 (Claude)" },
            { "<leader>Cc", desc = "切換 Claude Code" },
            { "<leader>Cf", desc = "聚焦 Claude Code" },
            { "<leader>Cm", desc = "選擇 Claude 模型" },
            { "<leader>Cs", desc = "發送選取內容到 Claude", mode = "v" },
            { "<leader>Ca", desc = "添加當前文件到 Claude" },
            { "<leader>CA", desc = "添加選取範圍到 Claude", mode = "v" },
            { "<leader>Cy", desc = "接受 Claude 的修改" },
            { "<leader>Cn", desc = "拒絕 Claude 的修改" },

            -- ============================
            -- 代碼折疊 (nvim-ufo)
            -- ============================
            { "zR", desc = "打開所有折疊" },
            { "zM", desc = "關閉所有折疊" },
            { "zr", desc = "減少折疊層級" },
            { "zm", desc = "增加折疊層級" },
            { "zp", desc = "預覽折疊或顯示懸浮資訊" },
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
