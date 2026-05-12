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

        -- 使用 dracula 作為基礎主題（更適合 dracula_pro）
        local transparent_theme = require("lualine.themes.dracula")
        
        -- 將所有部分的背景設為 NONE
        for _, mode in pairs(transparent_theme) do
            for _, section in pairs(mode) do
                if type(section) == "table" then
                    section.bg = "NONE"
                    -- 如果文字顏色太淺，可以在這裡強制加深或調整
                    -- 但通常 dracula 主題的 fg 已經很鮮豔
                end
            end
        end

        lualine.setup({
            -- ============================
            -- 主題設定
            -- ============================
            options = {
                theme = transparent_theme,
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
                      "filename",                 -- 顯示目前檔案名稱

                      file_status = true,          -- 顯示檔案狀態（是否唯讀、是否已修改）
                      newfile_status = false,      -- 是否顯示「新檔案」狀態（建立後尚未寫入磁碟）

                      path = 4,                    -- 檔案路徑顯示方式
                                                   -- 0：只顯示檔名
                                                   -- 1：顯示相對路徑
                                                   -- 2：顯示完整絕對路徑
                                                   -- 3：顯示完整絕對路徑，家目錄以 ~ 取代
                                                   -- 4：顯示父目錄 + 檔名，家目錄以 ~ 取代

                      shorting_target = 40,        -- 當路徑過長時自動縮短，保留 40 個字元空間給其他元件
                                                   -- 也可以改成 function 動態回傳縮短目標長度

                      symbols = {
                        modified = '[+]',          -- 檔案已修改但尚未儲存
                        readonly = '[-]',          -- 檔案為唯讀或不可寫
                        unnamed = '[無名稱]',      -- 未命名的 buffer
                        newfile = '[新檔案]',      -- 新建但尚未寫入的檔案
                      }
                    }
                },

                -- 右側區域
                lualine_x = {
                    -- Noice 命令狀態（顯示部分輸入的命令，如 g、d 等）
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    -- Noice 模式狀態
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = { fg = "#ff9e64" },
                    },
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
                    "lsp_status",
                    "encoding",                 -- 檔案編碼（utf-8 等）
                    "fileformat",               -- 檔案格式（unix, dos, mac）
                    "filetype",                 -- 檔案類型
                },
                lualine_y = { "progress" },     -- 檔案進度（百分比）
                lualine_z = {
                    "selectioncount",
                    "location", -- 游標位置（行:列）
                    {
                        "datetime",
                        style = "%H:%M"
                    },
                },
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
