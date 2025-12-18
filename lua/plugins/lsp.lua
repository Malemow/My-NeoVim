-- ============================
-- LSP 設定：語言伺服器協定
-- ============================
-- 功能：自動補全、跳轉定義、錯誤檢查、重構等
-- 包含三個插件：
-- 1. mason.nvim - LSP 伺服器管理器
-- 2. mason-lspconfig.nvim - mason 和 lspconfig 的橋接
-- 3. nvim-lspconfig - LSP 配置

return {
    -- ============================
    -- 1. Mason: LSP 伺服器管理器
    -- ============================
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- ============================
    -- 2. Mason-LSPConfig: 橋接插件
    -- ============================
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                -- ============================
                -- 自動安裝這些 LSP 伺服器
                -- ============================
                ensure_installed = {
                    -- 核心語言
                    "lua_ls",           -- Lua
                    "pyright",          -- Python

                    -- 前端開發（必裝）
                    "html",             -- HTML
                    "cssls",            -- CSS
                    "ts_ls",            -- TypeScript/JavaScript
                    "vue_ls",           -- Vue 3 (Volar)
                    "tailwindcss",      -- Tailwind CSS
                    "emmet_ls",         -- Emmet (HTML/CSS 快速編寫)

                    -- 數據格式
                    "jsonls",           -- JSON
                    "yamlls",           -- YAML
                    "taplo"             -- TOML

                    -- 如果你用其他語言，可以加上：
                    -- "rust_analyzer",  -- Rust
                    -- "gopls",          -- Go
                    -- "clangd",         -- C/C++
                    -- "jdtls",          -- Java
                },

                -- 自動安裝缺失的 LSP 伺服器
                automatic_installation = true,
            })
        end,
    },

    -- ============================
    -- 3. LSPConfig: LSP 配置
    -- ============================
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",  -- LSP 與補全系統整合
        },
        config = function()
            -- 暫時禁用 lspconfig 的 deprecation 警告（等待 v3.0 正式版本）
            local notify = vim.notify
            vim.notify = function(msg, ...)
                if msg:match("lspconfig") or msg:match("deprecated") then
                    return
                end
                notify(msg, ...)
            end

            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- 恢復原本的 notify
            vim.notify = notify

            -- ============================
            -- LSP 能力設定（讓 LSP 支援補全）
            -- ============================
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- ============================
            -- 當 LSP 附加到 buffer 時的設定
            -- ============================
            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                -- ============================
                -- LSP 快捷鍵
                -- ============================
                -- 跳轉到定義
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "跳到定義" }))

                -- 跳轉到聲明
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "跳到聲明" }))

                -- 顯示懸浮文件（函式說明）
                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "顯示文件" }))

                -- 跳轉到實作
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "跳到實作" }))

                -- 顯示函式簽名（參數提示）
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "函式簽名" }))

                -- 重新命名符號
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "重新命名" }))

                -- 查看引用（誰在使用這個變數/函式）
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "查看引用" }))

                -- 程式碼動作（快速修復、重構等）
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "程式碼動作" }))

                -- 顯示診斷訊息（錯誤詳情）
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "顯示錯誤" }))

                -- 跳到上一個診斷
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "上一個錯誤" }))

                -- 跳到下一個診斷
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "下一個錯誤" }))

                -- 格式化程式碼
                vim.keymap.set("n", "<leader>cf", function()
                    vim.lsp.buf.format({ async = true })
                end, vim.tbl_extend("force", opts, { desc = "格式化程式碼" }))
            end

            -- ============================
            -- 診斷配置（包含符號設定）
            -- ============================
            vim.diagnostic.config({
                virtual_text = true,      -- 在行尾顯示錯誤訊息
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
                update_in_insert = false, -- 插入模式不更新診斷
                underline = true,         -- 錯誤處加底線
                severity_sort = true,     -- 按嚴重程度排序
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- ============================
            -- 配置各個語言的 LSP
            -- ============================

            -- 定義要配置的 LSP 伺服器列表
            local servers = {
                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },  -- 識別 vim 全域變數
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },

                -- TypeScript/JavaScript (支援 React)
                ts_ls = {
                    filetypes = {
                        "javascript",
                        "javascriptreact",  -- JSX
                        "typescript",
                        "typescriptreact",  -- TSX
                    },
                },

                -- Vue 3 (Volar)
                vue_ls = {
                    filetypes = { "vue" },
                },

                -- Tailwind CSS
                tailwindcss = {
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "vue",
                    },
                },

                -- Emmet (HTML/CSS 快速編寫)
                emmet_ls = {
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "vue",
                    },
                },

                -- Python
                pyright = {},

                -- HTML
                html = {},

                -- CSS
                cssls = {},

                -- JSON
                jsonls = {},

                -- YAML
                yamlls = {},

                -- TOML
                taplo = {
                    filetypes = { "toml" },
                    -- 重要：這對於在非 git 存儲庫中使用 taplo LSP 是必需的
                    root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
                },
            }

            -- 統一配置所有 LSP 伺服器
            -- 暫時抑制 lspconfig 的棄用警告（setup 調用時）
            local old_notify = vim.notify
            vim.notify = function(msg, ...)
                if type(msg) == "string" and (msg:match("lspconfig") or msg:match("deprecated")) then
                    return
                end
                old_notify(msg, ...)
            end

            for server_name, server_config in pairs(servers) do
                local config = vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, server_config)

                lspconfig[server_name].setup(config)
            end

            -- 恢復 notify
            vim.notify = old_notify

            -- ============================
            -- 使用說明
            -- ============================
            -- 【LSP 快捷鍵】
            -- gd               : 跳到定義（Go to Definition）
            -- gD               : 跳到聲明（Go to Declaration）
            -- gi               : 跳到實作（Go to Implementation）
            -- gr               : 查看引用（References）
            -- K                : 顯示文件（Hover Documentation）
            -- <C-k>            : 函式簽名提示
            -- <Space>rn        : 重新命名符號
            -- <Space>ca        : 程式碼動作（快速修復）
            -- <Space>d         : 顯示錯誤詳情
            -- [d / ]d          : 跳到上/下一個錯誤
            -- <Space>cf        : 格式化程式碼
            --
            -- 【管理 LSP 伺服器】
            -- :Mason           : 開啟 Mason UI（安裝/更新 LSP）
            -- :LspInfo         : 查看當前 buffer 的 LSP 狀態
            -- :LspInstall      : 安裝 LSP 伺服器
            -- :LspUninstall    : 解除安裝 LSP 伺服器
            --
            -- 【實用工作流程】
            -- 1. 開啟檔案，LSP 會自動啟動
            -- 2. 將游標移到函式/變數上，按 gd 跳到定義
            -- 3. 按 K 查看函式說明文件
            -- 4. 按 gr 查看哪裡使用了這個函式
            -- 5. 按 <Space>rn 重新命名變數（自動改所有引用）
            -- 6. 有錯誤時，按 <Space>d 查看詳情
            -- 7. 按 <Space>ca 查看可用的快速修復
            --
            -- 【診斷符號說明】
            --  : 錯誤（Error）
            --  : 警告（Warning）
            --  : 提示（Hint）
            --  : 資訊（Info）
        end,
    },
}
