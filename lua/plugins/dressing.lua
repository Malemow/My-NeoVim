-- ============================
-- dressing.nvim: 美化輸入框和選擇器
-- ============================
-- GitHub: https://github.com/stevearc/dressing.nvim
-- 功能：美化 vim.ui.select 和 vim.ui.input

return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("dressing").setup({
            -- ============================
            -- 輸入框設定（vim.ui.input）
            -- ============================
            input = {
                -- 啟用
                enabled = true,

                -- 預設提示符號
                default_prompt = "➤ ",

                -- 標題位置
                title_pos = "left",

                -- 插入模式開始位置
                insert_only = true,
                start_in_insert = true,

                -- 邊框樣式
                border = "rounded",

                -- 相對位置
                relative = "cursor",

                -- 優先使用的後端
                prefer_width = 40,
                width = nil,
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },

                -- 視窗選項
                win_options = {
                    winblend = 10,
                    wrap = false,
                    list = true,
                    listchars = "precedes:…,extends:…",
                    sidescrolloff = 0,
                },

                -- 特定提示的覆蓋設定
                override = function(conf)
                    -- 這裡可以根據提示內容自訂配置
                    return conf
                end,

                -- 在輸入完成後的回調
                get_config = nil,
            },

            -- ============================
            -- 選擇器設定（vim.ui.select）
            -- ============================
            select = {
                -- 啟用
                enabled = true,

                -- 優先使用的後端
                backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

                -- 去除空格
                trim_prompt = true,

                -- Telescope 設定
                telescope = require("telescope.themes").get_dropdown({
                    layout_config = {
                        width = 0.8,
                        height = 0.8,
                    },
                }),

                -- FZF 設定
                fzf = {
                    window = {
                        width = 0.5,
                        height = 0.4,
                    },
                },

                -- FZF Lua 設定
                fzf_lua = {
                    winopts = {
                        height = 0.5,
                        width = 0.5,
                    },
                },

                -- Nui 設定
                nui = {
                    position = "50%",
                    size = nil,
                    relative = "editor",
                    border = {
                        style = "rounded",
                    },
                    buf_options = {
                        swapfile = false,
                        filetype = "DressingSelect",
                    },
                    win_options = {
                        winblend = 10,
                    },
                    max_width = 80,
                    max_height = 40,
                    min_width = 40,
                    min_height = 10,
                },

                -- 內建選擇器設定
                builtin = {
                    border = "rounded",
                    relative = "editor",

                    buf_options = {},
                    win_options = {
                        winblend = 10,
                        cursorline = true,
                        cursorlineopt = "both",
                    },

                    width = nil,
                    max_width = { 140, 0.8 },
                    min_width = { 40, 0.2 },
                    height = nil,
                    max_height = 0.9,
                    min_height = { 10, 0.2 },

                    -- 映射
                    mappings = {
                        ["<Esc>"] = "Close",
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },

                    override = function(conf)
                        return conf
                    end,
                },

                -- 格式化函式
                format_item_override = {},

                -- 在選擇後的回調
                get_config = nil,
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【美化效果】
        --
        -- 1. 輸入框（vim.ui.input）
        --    當插件或 LSP 要求輸入時
        --    會顯示美化的浮動輸入框
        --    例如：重新命名變數（<Space>rn）
        --
        -- 2. 選擇器（vim.ui.select）
        --    當需要選擇選項時
        --    會使用 Telescope（如果有）或美化的選單
        --    例如：程式碼動作（<Space>ca）
        --
        -- 【使用場景】
        --
        -- 場景 1：重新命名變數
        --   按 <Space>rn（LSP 重新命名）
        --   原本：底部命令列輸入
        --   現在：游標旁出現圓角輸入框 ✨
        --
        -- 場景 2：程式碼動作
        --   按 <Space>ca（Code Actions）
        --   原本：簡陋的選單
        --   現在：Telescope 美化選單 ✨
        --
        -- 場景 3：選擇 LSP 伺服器
        --   當有多個 LSP 可用時
        --   原本：文字選單
        --   現在：美化的選擇器 ✨
        --
        -- 【後端優先順序】
        -- select 會按順序嘗試：
        -- 1. telescope（你有，會優先使用）
        -- 2. fzf_lua
        -- 3. fzf
        -- 4. builtin（內建美化版）
        -- 5. nui
        --
        -- 【注意事項】
        -- 1. 自動整合，不需要額外設定
        -- 2. 所有使用 vim.ui.input 和 vim.ui.select 的地方都會被美化
        -- 3. 包括 LSP、插件、自訂腳本等
        --
        -- 【範例】
        -- 美化前：
        --   :lua vim.ui.input({ prompt = "請輸入名稱: " }, function(input) print(input) end)
        --   顯示在底部命令列
        --
        -- 美化後：
        --   同樣的程式碼
        --   顯示為浮動輸入框，有圓角邊框 ✨
    end,
}
