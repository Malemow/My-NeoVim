-- ============================
-- telescope.nvim: 模糊搜尋工具
-- ============================
-- GitHub: https://github.com/nvim-telescope/telescope.nvim
-- 功能：強大的模糊搜尋工具，可以搜尋檔案、文字、buffer、Git commits 等

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- 必要依賴
        -- {
        --     "nvim-telescope/telescope-fzf-native.nvim",  -- 加速搜尋（需要 CMake 編譯）
        --     build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        -- },
        "nvim-tree/nvim-web-devicons",  -- 檔案圖示
        {
            "nvim-telescope/telescope-file-browser.nvim",  -- 檔案瀏覽器擴展，支援 .. 導航
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        -- ============================
        -- Telescope 配置
        -- ============================
        telescope.setup({
            defaults = {
                -- ============================
                -- 搜尋設定
                -- ============================
                prompt_prefix = "🔍 ",
                selection_caret = "➤ ",
                path_display = { "smart" },  -- 智能顯示路徑（縮短長路徑）

                -- ============================
                -- 效能優化（避免大目錄卡住）
                -- ============================
                file_ignore_patterns = {
                    "%.git/",
                    "node_modules/",
                    "%.cache/",
                    "build/",
                    "dist/",
                    "%.next/",
                    "%.nuxt/",
                    "target/",
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",  -- 移除開頭的空白，提升效能
                },
                -- 搜尋結果限制（避免記憶體爆掉）
                cache_picker = {
                    num_pickers = 10,
                    limit_entries = 1000,
                },

                -- ============================
                -- 快捷鍵設定（在 Telescope 視窗中使用）
                -- ============================
                mappings = {
                    i = {  -- 插入模式
                        ["<C-k>"] = actions.move_selection_previous,  -- 上移
                        ["<C-j>"] = actions.move_selection_next,      -- 下移
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,  -- 送到 quickfix
                        ["<C-x>"] = actions.delete_buffer,  -- 刪除 buffer（在 buffers 搜尋時）

                        -- 改變搜尋目錄
                        ["<C-h>"] = function(prompt_bufnr)
                            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.loop.cwd()
                            local parent_dir = vim.fn.fnamemodify(cwd, ":h")

                            actions.close(prompt_bufnr)
                            require("telescope.builtin").find_files({
                                prompt_title = "Find Files (Parent: " .. vim.fn.fnamemodify(parent_dir, ":t") .. ")",
                                cwd = parent_dir,
                            })
                        end,
                    },
                    n = {  -- 普通模式
                        ["<C-h>"] = function(prompt_bufnr)
                            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.loop.cwd()
                            local parent_dir = vim.fn.fnamemodify(cwd, ":h")

                            actions.close(prompt_bufnr)
                            require("telescope.builtin").find_files({
                                prompt_title = "Find Files (Parent: " .. vim.fn.fnamemodify(parent_dir, ":t") .. ")",
                                cwd = parent_dir,
                            })
                        end,
                    },
                },
            },
            pickers = {
                -- ============================
                -- 各個搜尋器的特定設定
                -- ============================
                find_files = {
                    hidden = true,  -- 顯示隱藏檔案（.gitignore 中的檔案仍會被忽略）
                    -- 如果想顯示所有檔案（包括 .gitignore）：
                    -- find_command = { "rg", "--files", "--hidden", "--no-ignore" }
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }  -- 在隱藏檔案中也搜尋
                    end,
                },
            },
            extensions = {
                -- ============================
                -- File Browser 擴展配置
                -- ============================
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = false,  -- 不替換 netrw
                    hidden = { file_browser = true, folder_browser = true },  -- 顯示隱藏檔案
                    respect_gitignore = false,  -- 顯示 .gitignore 中的檔案
                    -- 啟用路徑導航（可輸入 .. 返回上層）
                    path_display = { "smart" },
                    mappings = {
                        ["i"] = {
                            -- 在插入模式下可以直接輸入 ../
                        },
                        ["n"] = {
                            -- h 返回上層
                            ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                        },
                    },
                },
            },
        })

        -- ============================
        -- 載入擴充功能
        -- ============================
        -- telescope.load_extension("fzf")  -- 載入 fzf 原生搜尋（編譯失敗時先註解）
        telescope.load_extension("file_browser")  -- 載入 file browser 擴展

        -- ============================
        -- 快捷鍵設定
        -- ============================
        local keymap = vim.keymap

        -- 搜尋檔案（在當前專案中）
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "搜尋檔案" })

        -- 檔案瀏覽器（支援輸入 .. 返回上層）
        keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "檔案瀏覽器 (可輸入 ..)" })

        -- 從根目錄打開檔案瀏覽器
        keymap.set("n", "<leader>fE", "<cmd>Telescope file_browser<cr>", { desc = "檔案瀏覽器 (根目錄)" })

        -- 搜尋最近開啟的檔案
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "搜尋最近檔案" })

        -- 搜尋文字（在當前專案中）- 類似 VSCode 的全域搜尋
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "搜尋文字" })

        -- 搜尋當前檔案中的文字
        keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "搜尋當前檔案" })

        -- 搜尋 buffers（已開啟的檔案）
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "搜尋 buffers" })

        -- 搜尋快捷鍵
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "搜尋快捷鍵" })

        -- 搜尋 Git commits
        keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "搜尋 commits" })

        -- 搜尋 Git 分支
        keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "搜尋分支" })

        -- 搜尋 Git 狀態（變更的檔案）
        keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "搜尋 Git 狀態" })

        -- 搜尋 help tags（Neovim 說明文件）
        keymap.set("n", "<leader>f?", "<cmd>Telescope help_tags<cr>", { desc = "搜尋說明文件" })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本使用】
        -- 1. 按快捷鍵開啟 Telescope（例如 <Space>ff）
        -- 2. 開始輸入，結果會即時過濾
        -- 3. 用 <C-j>/<C-k> 或 ↓/↑ 上下移動
        -- 4. 按 Enter 開啟選中的項目
        -- 5. 按 Esc 關閉 Telescope
        --
        -- 【快捷鍵總覽】
        -- <Space>ff    : 搜尋檔案（當前專案）⭐ 最常用
        -- <Space>fs    : 搜尋文字內容（類似 Ctrl+Shift+F）
        -- <Space>fb    : 搜尋已開啟的 buffer
        -- <Space>fr    : 搜尋最近開啟的檔案
        -- <Space>fc    : 搜尋當前檔案內容
        -- <Space>fk    : 搜尋快捷鍵
        -- <Space>f?    : 搜尋說明文件
        -- <Space>gc    : 搜尋 Git commits
        -- <Space>gb    : 搜尋 Git 分支
        -- <Space>gs    : 搜尋 Git 變更狀態
        --
        -- 【在 Telescope 視窗中】
        -- <C-j>/<C-k>  : 上下移動
        -- <C-h>        : 往上層目錄搜尋 ⭐ 新增
        -- Enter        : 開啟檔案
        -- <C-x>        : 水平分割開啟
        -- <C-v>        : 垂直分割開啟
        -- <C-t>        : 在新 tab 開啟
        -- <C-q>        : 送到 quickfix 列表
        -- Esc          : 關閉 Telescope
        --
        -- 【實用工作流程】
        -- 1. 找檔案：<Space>ff → 輸入檔名 → Enter
        -- 2. 全域搜尋：<Space>fs → 輸入關鍵字 → 找到使用位置
        -- 3. 切換 buffer：<Space>fb → 選擇檔案
        -- 4. 查看最近檔案：<Space>fr → 快速回到之前編輯的檔案
        --
        -- 【進階技巧】
        -- - 搜尋時支援模糊匹配：輸入 "usrctl" 可以找到 "user_controller.lua"
        -- - 支援正則表達式搜尋
        -- - 可以用空格分隔多個搜尋詞
        -- - 在搜尋結果中按 <C-q> 可以把結果送到 quickfix，方便批次處理
    end,
}
