-- ============================
-- mini.indentscope: 縮排範圍視覺化
-- ============================
-- GitHub: https://github.com/echasnovski/mini.indentscope
-- 功能：高亮顯示當前游標所在的縮排範圍，讓程式碼結構更清楚

return {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local indentscope = require("mini.indentscope")

        indentscope.setup({
            -- ============================
            -- 視覺化設定
            -- ============================
            draw = {
                delay = 100,  -- 延遲（毫秒），避免在快速移動時閃爍
                animation = indentscope.gen_animation.none(),  -- 不使用動畫（提升效能）
            },

            -- ============================
            -- 符號設定
            -- ============================
            symbol = "│",  -- 使用垂直線顯示範圍

            -- ============================
            -- 選項
            -- ============================
            options = {
                -- 嘗試使用 border 顯示範圍（上下邊界）
                try_as_border = true,

                -- 在哪些檔案類型啟用
                -- 空表示所有檔案類型都啟用
            },

            -- ============================
            -- 映射（快捷鍵）
            -- ============================
            mappings = {
                -- 物件文字選取（在範圍內）
                object_scope = "ii",      -- 選取當前縮排範圍（不含邊界）
                object_scope_with_border = "ai",  -- 選取當前縮排範圍（含邊界）

                -- 跳到範圍的開始/結束
                goto_top = "[i",    -- 跳到範圍頂部
                goto_bottom = "]i", -- 跳到範圍底部
            },
        })

        -- ============================
        -- 在特定檔案類型禁用
        -- ============================
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "lazy",
                "mason",
                "notify",
                "NvimTree",
                "TelescopePrompt",
                "TelescopeResults",
                "terminal",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【自動功能】
        -- - 當游標在程式碼中移動時，會自動高亮顯示當前的縮排範圍
        -- - 範圍用垂直線（│）標示
        -- - 特別適合查看函式、類別、if/for 語句的範圍
        --
        -- 【文字物件】
        -- ii           : 選取當前縮排範圍（inner）
        --                例如：在函式內按 vii 可選取整個函式內容
        -- ai           : 選取當前縮排範圍（含邊界）
        --                例如：在函式內按 vai 可選取包含函式定義的所有內容
        --
        -- 【範圍導航】
        -- [i           : 跳到當前範圍的開始
        -- ]i           : 跳到當前範圍的結束
        --
        -- 【使用場景】
        -- 1. 查看當前游標在哪個函式/類別/區塊中
        -- 2. 快速選取整個函式/區塊（用 vii）
        -- 3. 在嵌套很深的程式碼中快速跳轉
        --
        -- 【實用組合】
        -- dii          : 刪除當前縮排範圍的內容
        -- cii          : 修改當前縮排範圍的內容
        -- yii          : 複製當前縮排範圍的內容
        -- vii          : 選取當前縮排範圍
    end,
}
