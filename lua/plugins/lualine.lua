-- ============================
-- lualine: 美觀且強大的狀態列
-- ============================
-- GitHub: https://github.com/nvim-lualine/lualine.nvim
-- 功能：在底部顯示美觀的狀態列，支援豐富的自訂和主題

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",  -- 顯示檔案圖示
    },
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            -- ============================
            -- 主題設定
            -- ============================
            options = {
                theme = "auto",  -- 自動適配你的配色主題
                -- 其他主題選項：
                -- "gruvbox", "tokyonight", "catppuccin",
                -- "dracula", "nord", "onedark", "palenight"

                -- ============================
                -- 分隔符號樣式
                -- ============================
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                -- 其他樣式選項：
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },

                -- ============================
                -- 全域設定
                -- ============================
                disabled_filetypes = {
                    statusline = { "NvimTree" },  -- 在 nvim-tree 中不顯示狀態列
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,  -- 使用全域狀態列（所有視窗共用一個）
                refresh = {
                    statusline = 1000,  -- 更新頻率（毫秒）
                    tabline = 1000,
                    winbar = 1000,
                },
            },

            -- ============================
            -- 狀態列佈局
            -- ============================
            -- 分為左、中、右三個區域（a-c 為左，x-z 為右）
            sections = {
                -- 左側區域
                lualine_a = { "mode" },           -- 顯示模式（NORMAL, INSERT, VISUAL 等）
                lualine_b = { "branch", "diff" }, -- Git 分支 + diff 統計
                lualine_c = {
                    {
                        "filename",
                        file_status = true,     -- 顯示檔案狀態（修改、唯讀等）
                        path = 1,               -- 0: 只顯示檔名, 1: 相對路徑, 2: 絕對路徑
                    }
                },

                -- 右側區域
                lualine_x = {
                    {
                        "diagnostics",          -- 顯示 LSP 診斷訊息（錯誤、警告等）
                        sources = { "nvim_lsp" },
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                    "encoding",                 -- 檔案編碼（utf-8 等）
                    "fileformat",               -- 檔案格式（unix, dos, mac）
                    "filetype",                 -- 檔案類型
                },
                lualine_y = { "progress" },     -- 檔案進度（百分比）
                lualine_z = { "location" },     -- 游標位置（行:列）
            },

            -- 非當前視窗的狀態列（較簡化）
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },

            -- ============================
            -- 其他區域（選用）
            -- ============================
            tabline = {},      -- 頂部標籤列（可用來顯示 buffer）
            winbar = {},       -- 視窗頂部列
            inactive_winbar = {},

            -- ============================
            -- 擴充功能
            -- ============================
            extensions = { "nvim-tree" },  -- 為 nvim-tree 提供特殊支援
        })

        -- ============================
        -- 狀態列顯示說明
        -- ============================
        -- 【左側區域】
        -- - mode: 當前模式（NORMAL、INSERT、VISUAL 等）
        --   不同模式會用不同顏色顯示
        -- - branch: Git 分支名稱
        -- - diff: 顯示檔案的 git 變更統計
        --   +5 -2 ~3 （新增 5 行、刪除 2 行、修改 3 行）
        -- - filename: 檔案名稱（相對路徑）
        --   如果檔案已修改會顯示 [+]
        --
        -- 【右側區域】
        -- - diagnostics: LSP 診斷訊息數量
        --    2   1 （2 個錯誤、1 個警告）
        -- - encoding: 檔案編碼（通常是 utf-8）
        -- - fileformat: 換行符號格式（unix/dos/mac）
        -- - filetype: 檔案類型（lua、python、javascript 等）
        -- - progress: 檔案捲動進度（Top/Bot/50%）
        -- - location: 游標位置（行號:列號）
        --
        -- ============================
        -- 自訂技巧
        -- ============================
        -- 1. 修改主題：將 theme = "auto" 改成你喜歡的主題名稱
        -- 2. 調整分隔符：修改 component_separators 和 section_separators
        -- 3. 新增元件：在 sections 中加入其他元件
        --    例如：{ "datetime", style = "%H:%M" } 顯示時間
        -- 4. 調整順序：直接移動 sections 中的元件位置
    end,
}
