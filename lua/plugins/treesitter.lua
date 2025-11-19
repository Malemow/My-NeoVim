-- ============================
-- nvim-treesitter: 語法高亮和程式碼理解
-- ============================
-- GitHub: https://github.com/nvim-treesitter/nvim-treesitter
-- 功能：更精確的語法高亮、智能選取、程式碼折疊、自動縮排

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",  -- 安裝後自動更新所有語言的 parser
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",  -- 文字物件（選取函式、類別等）
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            -- ============================
            -- 高亮設定
            -- ============================
            highlight = {
                enable = true,  -- 啟用 Treesitter 語法高亮
                additional_vim_regex_highlighting = false,  -- 關閉 Vim 傳統的正則高亮（避免衝突）
            },

            -- ============================
            -- 自動縮排
            -- ============================
            indent = {
                enable = true,  -- 啟用 Treesitter 的智能縮排
            },

            -- ============================
            -- 自動安裝語言 parser
            -- ============================
            ensure_installed = {
                -- Web 前端開發（核心）
                "html",
                "css",
                "scss",              -- Sass/SCSS
                "javascript",        -- 已包含 JSX 支援
                "typescript",
                "tsx",               -- React (TypeScript)
                -- 注意："jsx" 已整合到 "javascript" parser 中，不需要單獨安裝
                "vue",               -- Vue 3
                "json",
                "yaml",

                -- 後端
                "python",
                "lua",
                "vim",
                "vimdoc",
                "bash",

                -- 其他
                "markdown",
                "markdown_inline",
                "gitignore",
                "dockerfile",

                -- 如果你還用其他語言，可以加上：
                -- "rust",
                -- "go",
                -- "java",
                -- "c",
                -- "cpp",
                -- "c_sharp",
                -- "php",
                -- "ruby",
            },

            -- ============================
            -- 增量選取（智能選取）
            -- ============================
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",       -- 開始選取（按一次選當前節點）
                    node_incremental = "<C-space>",     -- 擴大選取範圍（選父節點）
                    scope_incremental = false,          -- 不使用 scope 選取
                    node_decremental = "<bs>",          -- 縮小選取範圍（Backspace）
                },
            },

            -- ============================
            -- 自動安裝選項
            -- ============================
            auto_install = true,  -- 開啟新的檔案類型時自動安裝對應的 parser

            -- ============================
            -- 忽略特定檔案類型
            -- ============================
            ignore_install = {},  -- 不想自動安裝的語言（留空表示都安裝）

            -- ============================
            -- 同步安裝
            -- ============================
            sync_install = false,  -- 是否同步安裝（false = 背景安裝，不阻塞）
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【語法高亮】
        -- Treesitter 會自動提供更精確的語法高亮
        -- 不需要任何操作，開啟檔案就會生效
        --
        -- 【智能選取（超好用！）】
        -- 1. 在程式碼中按 <C-space>（Ctrl + 空格）
        -- 2. 會選取當前的語法節點（例如一個變數）
        -- 3. 再按 <C-space> 會擴大選取（例如選取整個表達式）
        -- 4. 繼續按會選取更大範圍（整個語句、整個函式、整個類別）
        -- 5. 按 Backspace 可以縮小選取範圍
        --
        -- 範例：
        -- let result = calculate(x + y);
        --              ^
        -- 第1次按 <C-space>: 選取 "calculate"
        -- 第2次按 <C-space>: 選取 "calculate(x + y)"
        -- 第3次按 <C-space>: 選取整個賦值語句
        -- 第4次按 <C-space>: 選取整個行
        --
        -- 【查看已安裝的語言】
        -- :TSInstallInfo
        --
        -- 【手動安裝語言】
        -- :TSInstall <language>
        -- 例如：:TSInstall rust
        --
        -- 【更新所有語言】
        -- :TSUpdate
        --
        -- 【檢查 Treesitter 狀態】
        -- :checkhealth nvim-treesitter
        --
        -- 【語法高亮效果】
        -- Treesitter 的高亮比傳統的正則高亮更準確：
        -- - 函式名稱、變數名稱、類別名稱會有不同顏色
        -- - 能正確識別閉包、匿名函式
        -- - 能識別 JSX/TSX 中的 HTML 標籤
        -- - 能識別字串插值 (string interpolation)
        --
        -- 【自動縮排】
        -- 在編輯時會根據語法自動調整縮排
        -- 特別適合複雜的嵌套結構
    end,
}
