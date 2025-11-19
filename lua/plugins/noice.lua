-- ============================
-- noice.nvim: 美化 Neovim UI
-- ============================
-- GitHub: https://github.com/folke/noice.nvim
-- 功能：美化命令列、通知、LSP 進度、搜尋等

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",  -- UI 組件庫
        "rcarriga/nvim-notify",  -- 通知後端
    },
    config = function()
        require("noice").setup({
            -- ============================
            -- LSP 設定
            -- ============================
            lsp = {
                -- 覆蓋 LSP 的 markdown 渲染
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },

                -- LSP 進度通知
                progress = {
                    enabled = true,
                    format = "lsp_progress",
                    format_done = "lsp_progress_done",
                    view = "mini",  -- 使用 mini 視圖（右下角）
                },

                -- Hover 文檔
                hover = {
                    enabled = true,
                    silent = false,
                },

                -- 函式簽名
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        luasnip = true,
                        throttle = 50,
                    },
                },

                -- 訊息
                message = {
                    enabled = true,
                },

                -- 文檔
                documentation = {
                    view = "hover",
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        win_options = { concealcursor = "n", conceallevel = 3 },
                    },
                },
            },

            -- ============================
            -- 預設設定
            -- ============================
            presets = {
                bottom_search = false,         -- 搜尋不使用底部樣式
                command_palette = true,        -- 命令面板樣式
                long_message_to_split = true,  -- 長訊息分割顯示
                inc_rename = false,            -- 重新命名不使用 noice
                lsp_doc_border = true,         -- LSP 文檔加邊框
            },

            -- ============================
            -- 視圖設定
            -- ============================
            views = {
                cmdline_popup = {
                    position = {
                        row = "50%",  -- 命令列位置（中間）
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = "60%",
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },

            -- ============================
            -- 路由設定（控制訊息如何顯示）
            -- ============================
            routes = {
                -- 過濾掉一些煩人的訊息
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "lines",
                    },
                    opts = { skip = true },
                },
                -- LSP 進度訊息使用 mini 視圖
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                    },
                    opts = { skip = false },
                    view = "mini",
                },
            },
        })

        -- ============================
        -- nvim-notify 配置（通知後端）
        -- ============================
        require("notify").setup({
            -- 背景顏色
            background_colour = "#000000",

            -- 超時時間（毫秒）
            timeout = 3000,

            -- 最大寬度
            max_width = 50,

            -- 最大高度
            max_height = 10,

            -- 動畫樣式
            stages = "fade_in_slide_out",

            -- 渲染方式
            render = "default",

            -- 圖示
            icons = {
                ERROR = "",
                WARN = "",
                INFO = "",
                DEBUG = "",
                TRACE = "✎",
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【美化效果】
        --
        -- 1. 命令列（Cmdline）
        --    輸入 : / ? 時會顯示在螢幕中間的浮動視窗
        --    更現代化的外觀
        --
        -- 2. 通知（Notifications）
        --    所有訊息（儲存檔案、錯誤、警告等）
        --    會以美化的彈窗顯示在右上角
        --    自動淡出
        --
        -- 3. LSP 進度
        --    LSP 載入、分析時會在右下角顯示進度
        --    不會干擾編輯
        --
        -- 4. LSP 文檔
        --    按 K 查看文檔時有圓角邊框
        --    更好看的 markdown 渲染
        --
        -- 5. 搜尋
        --    搜尋訊息更清楚
        --
        -- 【快捷鍵】
        -- :Noice         : 開啟 Noice 歷史記錄
        -- :Noice dismiss : 關閉所有通知
        -- :Noice errors  : 顯示所有錯誤
        -- :Noice stats   : 顯示統計資訊
        --
        -- 【通知歷史】
        -- 所有通知都會被記錄
        -- 使用 :Noice 可以查看歷史通知
        --
        -- 【注意事項】
        -- 1. 第一次載入可能會稍慢（需要初始化）
        -- 2. 如果覺得通知太多，可以調整 routes 過濾更多訊息
        -- 3. 如果覺得命令列位置不喜歡，可以調整 cmdline_popup 的 position
        --
        -- 【自訂通知】
        -- 在 Lua 中可以這樣使用：
        -- vim.notify("訊息內容", vim.log.levels.INFO)
        -- vim.notify("錯誤訊息", vim.log.levels.ERROR)
        -- vim.notify("警告訊息", vim.log.levels.WARN)
    end,
}
