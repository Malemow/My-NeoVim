-- ============================
-- mini.hipatterns: 高亮顯示特定模式
-- ============================
-- GitHub: https://github.com/echasnovski/mini.hipatterns
-- 功能：顏色預覽（#ff0000）+ TODO 註解高亮 + 自訂模式高亮

return {
    "echasnovski/mini.hipatterns",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local hipatterns = require("mini.hipatterns")

        hipatterns.setup({
            highlighters = {
                -- ============================
                -- 顏色預覽（Hex 顏色碼）
                -- ============================
                -- 高亮 #RRGGBB 和 #RGB 格式的顏色
                hex_color = hipatterns.gen_highlighter.hex_color(),

                -- ============================
                -- TODO 註解高亮
                -- ============================
                -- FIXME: 紅色高亮
                fixme = {
                    pattern = "%f[%w]()FIXME()%f[%W]",
                    group = "MiniHipatternsFixme",
                },

                -- HACK: 橙色高亮
                hack = {
                    pattern = "%f[%w]()HACK()%f[%W]",
                    group = "MiniHipatternsHack",
                },

                -- TODO: 藍色高亮
                todo = {
                    pattern = "%f[%w]()TODO()%f[%W]",
                    group = "MiniHipatternsTodo",
                },

                -- NOTE: 綠色高亮
                note = {
                    pattern = "%f[%w]()NOTE()%f[%W]",
                    group = "MiniHipatternsNote",
                },

                -- ============================
                -- 自訂模式（可選）
                -- ============================
                -- 可以在這裡添加更多自訂高亮模式
                -- 例如：高亮特定變數名、關鍵字等
            },
        })

        -- ============================
        -- 設定 TODO 註解的顏色
        -- ============================
        vim.api.nvim_set_hl(0, "MiniHipatternsFixme", { fg = "#FFFFFF", bg = "#F44747", bold = true })
        vim.api.nvim_set_hl(0, "MiniHipatternsHack", { fg = "#000000", bg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "MiniHipatternsTodo", { fg = "#FFFFFF", bg = "#0098DD", bold = true })
        vim.api.nvim_set_hl(0, "MiniHipatternsNote", { fg = "#000000", bg = "#10B981", bold = true })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【顏色預覽】
        -- 在程式碼中寫 #ff0000 會自動顯示紅色背景
        -- 支援格式：
        --   - #RGB     （例如：#f00）
        --   - #RRGGBB  （例如：#ff0000）
        --
        -- 範例：
        --   color: #ff0000;     ← 會顯示紅色背景
        --   background: #00ff00; ← 會顯示綠色背景
        --
        -- 【TODO 註解高亮】
        -- 在註解中使用以下關鍵字會自動高亮：
        --
        -- FIXME: 需要修復的問題  ← 紅色背景
        -- HACK: 暫時性的解決方案 ← 橙色背景
        -- TODO: 待辦事項         ← 藍色背景
        -- NOTE: 重要說明         ← 綠色背景
        --
        -- 【支援的檔案類型】
        -- - 所有檔案類型都支援
        -- - 特別適合：
        --   - CSS/SCSS（顏色預覽）
        --   - JavaScript/TypeScript（TODO 註解）
        --   - Vue/React（inline styles）
        --   - HTML（style 屬性）
        --
        -- 【快捷鍵】
        -- 無需特殊快捷鍵，自動生效
        --
        -- 【實用技巧】
        -- 1. 在 CSS 中寫顏色碼時，直接看到顏色效果
        -- 2. 用 TODO: 標記待辦事項，容易看到
        -- 3. 用 FIXME: 標記 bug，紅色背景很醒目
        -- 4. 配合 Telescope 搜尋 TODO（:Telescope live_grep）
        --
        -- 【範例使用】
        -- CSS:
        --   .title { color: #ff0000; }  ← 紅色預覽
        --   .bg { background: #00ff00; } ← 綠色預覽
        --
        -- JavaScript:
        --   // TODO: 實作登入功能  ← 藍色高亮
        --   // FIXME: 修復記憶體洩漏 ← 紅色高亮
        --
        -- Vue/React:
        --   <div style="color: #ff0000">  ← 紅色預覽
    end,
}
