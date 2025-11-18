-- ============================
-- nvim-cmp: 自動補全系統
-- ============================
-- 功能：打字時自動顯示補全建議
-- 包含：補全引擎 + 多個補全源 + 代碼片段引擎

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- 進入插入模式時載入
    dependencies = {
        -- ============================
        -- 補全源
        -- ============================
        "hrsh7th/cmp-nvim-lsp",     -- LSP 補全源（最重要！）
        "hrsh7th/cmp-buffer",       -- Buffer 文字補全源
        "hrsh7th/cmp-path",         -- 檔案路徑補全源

        -- ============================
        -- 代碼片段引擎
        -- ============================
        "L3MON4D3/LuaSnip",         -- 代碼片段引擎
        "saadparwaiz1/cmp_luasnip", -- LuaSnip 補全源
        "rafamadriz/friendly-snippets", -- 預設代碼片段集合

        -- ============================
        -- 圖示
        -- ============================
        "onsails/lspkind.nvim",     -- 補全選單中顯示美觀的圖示
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- ============================
        -- 載入預設代碼片段
        -- ============================
        require("luasnip.loaders.from_vscode").lazy_load()

        -- ============================
        -- nvim-cmp 配置
        -- ============================
        cmp.setup({
            -- ============================
            -- 代碼片段設定
            -- ============================
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- ============================
            -- 補全視窗外觀
            -- ============================
            window = {
                completion = cmp.config.window.bordered(),      -- 補全選單加邊框
                documentation = cmp.config.window.bordered(),   -- 文件視窗加邊框
            },

            -- ============================
            -- 快捷鍵設定
            -- ============================
            mapping = cmp.mapping.preset.insert({
                -- 上下選擇補全項目
                ["<C-k>"] = cmp.mapping.select_prev_item(),     -- 上一個
                ["<C-j>"] = cmp.mapping.select_next_item(),     -- 下一個

                -- 捲動文件視窗
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),        -- 向上捲動
                ["<C-f>"] = cmp.mapping.scroll_docs(4),         -- 向下捲動

                -- 開啟/關閉補全選單
                ["<C-Space>"] = cmp.mapping.complete(),         -- 手動觸發補全
                ["<C-e>"] = cmp.mapping.abort(),                -- 關閉補全選單

                -- 確認選擇
                ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter 確認（不自動選第一個）
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()                  -- 如果選單開啟，選下一個
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()                -- 如果是代碼片段，展開或跳到下一個位置
                    else
                        fallback()                              -- 否則輸入 Tab
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()                  -- 選上一個
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)                        -- 跳到代碼片段的上一個位置
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- ============================
            -- 補全源設定（依優先順序）
            -- ============================
            sources = cmp.config.sources({
                { name = "nvim_lsp" },   -- LSP 補全（最優先）
                { name = "luasnip" },    -- 代碼片段
                { name = "buffer" },     -- Buffer 文字
                { name = "path" },       -- 檔案路徑
            }),

            -- ============================
            -- 補全項目格式設定（顯示圖示）
            -- ============================
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",   -- 顯示圖示 + 文字
                    maxwidth = 50,          -- 最大寬度
                    ellipsis_char = "...",  -- 超過寬度時的省略符號
                    menu = {
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    },
                }),
            },

            -- ============================
            -- 實驗性功能
            -- ============================
            experimental = {
                ghost_text = true,  -- 顯示幽靈文字（預覽補全結果）
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本使用】
        -- 1. 在插入模式開始打字
        -- 2. 補全選單會自動彈出
        -- 3. 用 <C-j>/<C-k> 或 ↓/↑ 選擇項目
        -- 4. 按 Tab 或 Enter 確認選擇
        -- 5. 按 Esc 或 <C-e> 關閉選單
        --
        -- 【快捷鍵總覽】
        -- <C-j>/<C-k>  : 上下選擇補全項目
        -- Tab          : 選下一個項目 / 展開代碼片段 / 跳到下一個佔位符
        -- Shift+Tab    : 選上一個項目 / 跳到上一個佔位符
        -- Enter        : 確認選擇
        -- <C-Space>    : 手動觸發補全
        -- <C-e>        : 關閉補全選單
        -- <C-b>/<C-f>  : 捲動文件視窗
        --
        -- 【補全源說明】
        -- [LSP]        : 來自語言伺服器（函式、變數、類別等）
        -- [Snippet]    : 代碼片段（例如 for 迴圈、if 語句模板）
        -- [Buffer]     : 當前 buffer 中已有的文字
        -- [Path]       : 檔案路徑（輸入 ./ 或 / 時觸發）
        --
        -- 【代碼片段範例】
        -- 輸入 "for" → 選擇 for 迴圈片段 → 按 Tab → 自動展開並可跳轉填空
        -- 輸入 "if" → 選擇 if 語句片段 → 按 Tab → 填寫條件
        -- 輸入 "func" → 選擇函式片段 → 按 Tab → 填寫函式名稱和參數
        --
        -- 【路徑補全範例】
        -- 輸入 require("./ → 會顯示當前目錄的檔案
        -- 輸入 import "./src/ → 會顯示 src 目錄的檔案
        --
        -- 【LSP 補全範例】
        -- 輸入 console. → 會顯示 log, error, warn 等方法
        -- 輸入變數名的前幾個字母 → 會顯示所有匹配的變數
        -- 輸入函式名 → 會顯示參數提示和文件說明
        --
        -- 【補全選單圖示說明】
        -- 󰊕 : 函式 (Function)
        -- 󰜢 : 變數 (Variable)
        -- 󰌗 : 類別 (Class)
        -- 󰏗 : 介面 (Interface)
        --  : 模組 (Module)
        --  : 屬性 (Property)
        --  : 關鍵字 (Keyword)
        --  : 代碼片段 (Snippet)
        --  : 文字 (Text)
        --
        -- 【進階技巧】
        -- 1. 如果補全沒自動出現,按 <C-Space> 手動觸發
        -- 2. 可以繼續打字來過濾補全結果
        -- 3. 使用 Tab 可以快速選擇並確認
        -- 4. 代碼片段中按 Tab 可以跳到下一個要填的位置
        -- 5. 游標移到函式上按 K 可以看完整文件
    end,
}
