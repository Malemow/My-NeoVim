-- ============================
-- aerial.nvim: 符號大綱視圖
-- ============================
-- GitHub: https://github.com/stevearc/aerial.nvim
-- 功能：在側邊欄顯示檔案的符號大綱（函式、類別、變數等），類似 VSCode 的 Outline

return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local aerial = require("aerial")

        aerial.setup({
            -- ============================
            -- 後端設定（符號來源）
            -- ============================
            -- 優先使用 LSP，如果 LSP 不可用則使用 Treesitter
            backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

            -- ============================
            -- 佈局設定
            -- ============================
            layout = {
                max_width = { 40, 0.2 },   -- 最大寬度：40 字元或 20% 視窗寬度
                width = 30,                 -- 預設寬度
                min_width = 20,             -- 最小寬度

                -- 位置：可選 "left", "right", "float"
                default_direction = "right",

                -- 保留最後的位置
                placement = "edge",
            },

            -- ============================
            -- 顯示設定
            -- ============================
            -- 自動關閉行為
            attach_mode = "global",  -- global: 所有 buffer 共用一個視窗

            -- 關閉視窗時的行為
            close_behavior = "auto",  -- auto: 自動決定是否關閉

            -- 顯示的最小符號層級（0 = 顯示所有）
            -- filter_kind = false,

            -- 高亮當前符號
            highlight_mode = "split_width",  -- 高亮整行

            -- 高亮最接近游標的符號
            highlight_closest = true,

            -- 高亮游標下的符號
            highlight_on_hover = true,

            -- 在視窗頂部顯示標題
            show_guides = true,  -- 顯示樹狀引導線

            -- ============================
            -- 圖示設定
            -- ============================
            icons = {},  -- 使用預設圖示

            -- ============================
            -- 自動開啟/關閉
            -- ============================
            -- 開啟檔案時自動開啟 aerial
            -- open_automatic = false,

            -- 自動關閉 aerial（當離開支援的檔案類型時）
            close_automatic_events = { "unsupported" },

            -- ============================
            -- 快捷鍵（在 aerial 視窗中）
            -- ============================
            keymaps = {
                ["?"] = "actions.show_help",
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.jump",
                ["<2-LeftMouse>"] = "actions.jump",
                ["<C-v>"] = "actions.jump_vsplit",
                ["<C-s>"] = "actions.jump_split",
                ["p"] = "actions.scroll",
                ["<C-j>"] = "actions.down_and_scroll",
                ["<C-k>"] = "actions.up_and_scroll",
                ["{"] = "actions.prev",
                ["}"] = "actions.next",
                ["[["] = "actions.prev_up",
                ["]]"] = "actions.next_up",
                ["q"] = "actions.close",
                ["o"] = "actions.tree_toggle",
                ["za"] = "actions.tree_toggle",
                ["O"] = "actions.tree_toggle_recursive",
                ["zA"] = "actions.tree_toggle_recursive",
                ["l"] = "actions.tree_open",
                ["zo"] = "actions.tree_open",
                ["L"] = "actions.tree_open_recursive",
                ["zO"] = "actions.tree_open_recursive",
                ["h"] = "actions.tree_close",
                ["zc"] = "actions.tree_close",
                ["H"] = "actions.tree_close_recursive",
                ["zC"] = "actions.tree_close_recursive",
                ["zr"] = "actions.tree_increase_fold_level",
                ["zR"] = "actions.tree_open_all",
                ["zm"] = "actions.tree_decrease_fold_level",
                ["zM"] = "actions.tree_close_all",
                ["zx"] = "actions.tree_sync_folds",
                ["zX"] = "actions.tree_sync_folds",
            },

            -- ============================
            -- Treesitter 設定
            -- ============================
            treesitter = {
                -- 當 Treesitter 分析完成後更新延遲（毫秒）
                update_delay = 300,
            },

            -- ============================
            -- LSP 設定
            -- ============================
            lsp = {
                -- 自動附加到支援符號的 LSP 客戶端
                -- diagnostics_trigger_update = true,

                -- 當文件符號變更時更新延遲（毫秒）
                update_delay = 300,

                -- 優先順序（當同時有多個後端時）
                -- priority = {
                --     py = { "pyright", "pylsp" },
                -- },
            },

            -- ============================
            -- 忽略的符號類型（可選）
            -- ============================
            -- filter_kind = {
            --     "Class",
            --     "Constructor",
            --     "Enum",
            --     "Function",
            --     "Interface",
            --     "Module",
            --     "Method",
            --     "Struct",
            -- },
        })

        -- ============================
        -- 快捷鍵設定
        -- ============================
        local keymap = vim.keymap

        -- 開關 aerial 視窗
        keymap.set("n", "<leader>cl", "<cmd>AerialToggle<CR>", { desc = "開關符號大綱" })

        -- 跳到下一個符號
        keymap.set("n", "]a", "<cmd>AerialNext<CR>", { desc = "下一個符號" })

        -- 跳到上一個符號
        keymap.set("n", "[a", "<cmd>AerialPrev<CR>", { desc = "上一個符號" })

        -- ============================
        -- Telescope 整合（如果需要）
        -- ============================
        -- keymap.set("n", "<leader>fa", "<cmd>Telescope aerial<cr>", { desc = "搜尋符號 (Aerial)" })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本使用】
        -- <Space>cl     : 開關符號大綱視窗
        -- ]a           : 跳到下一個符號
        -- [a           : 跳到上一個符號
        --
        -- 【在 aerial 視窗中】
        -- <CR>         : 跳到符號定義處
        -- o            : 展開/收合符號
        -- q            : 關閉視窗
        -- ?            : 顯示所有快捷鍵
        -- {/}          : 上/下一個符號
        -- [[ / ]]      : 上/下一個同級符號
        --
        -- 【樹狀操作（類似 Vim 折疊）】
        -- zo / zc      : 開啟/關閉當前節點
        -- zO / zC      : 遞迴開啟/關閉當前節點
        -- zR / zM      : 開啟/關閉所有節點
        --
        -- 【分割視窗開啟】
        -- <C-v>        : 在垂直分割視窗中開啟
        -- <C-s>        : 在水平分割視窗中開啟
        --
        -- 【顯示內容】
        -- - 函式 (Function)
        -- - 類別 (Class)
        -- - 方法 (Method)
        -- - 變數 (Variable)
        -- - 常數 (Constant)
        -- - 介面 (Interface)
        -- - 等等...
        --
        -- 【使用場景】
        -- 1. 快速瀏覽檔案中所有函式和類別
        -- 2. 在大檔案中快速跳轉到特定函式
        -- 3. 了解程式碼的整體結構
        -- 4. 配合 LSP 查看符號層級關係
        --
        -- 【提示】
        -- - aerial 會根據檔案類型自動選擇最佳後端（LSP 或 Treesitter）
        -- - 當前游標位置的符號會自動高亮
        -- - 支援大部分程式語言（JavaScript, TypeScript, Python, Lua, Vue 等）
    end,
}
