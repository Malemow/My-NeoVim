-- ============================
-- mini.animate: 動畫效果
-- ============================
-- GitHub: https://github.com/echasnovski/mini.animate
-- 功能：為 Neovim 添加流暢的動畫效果

return {
    "echasnovski/mini.animate",
    version = false,
    event = "VeryLazy",
    config = function()
        local animate = require("mini.animate")

        animate.setup({
            -- ============================
            -- 游標動畫
            -- ============================
            cursor = {
                -- 啟用游標移動動畫
                enable = true,

                -- 動畫時長（毫秒）
                timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),

                -- 動畫路徑
                path = animate.gen_path.line(),
            },

            -- ============================
            -- 捲動動畫
            -- ============================
            scroll = {
                -- 啟用捲動動畫
                enable = true,

                -- 動畫時長
                timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),

                -- 下標動畫
                subscroll = animate.gen_subscroll.equal({ predicate = function(total_scroll)
                    return total_scroll > 1
                end }),
            },

            -- ============================
            -- 調整視窗大小動畫
            -- ============================
            resize = {
                -- 啟用視窗調整大小動畫
                enable = false,  -- 預設關閉，避免太花俏

                -- 動畫時長
                timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
            },

            -- ============================
            -- 開關視窗動畫
            -- ============================
            open = {
                -- 啟用開啟視窗動畫
                enable = false,  -- 預設關閉

                -- 動畫時長
                timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),

                -- 視窗進入動畫
                winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
            },

            close = {
                -- 啟用關閉視窗動畫
                enable = false,  -- 預設關閉

                -- 動畫時長
                timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),

                -- 視窗退出動畫
                winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【啟用的動畫】
        -- 1. 游標移動動畫（cursor）✅
        --    - 游標移動時會有流暢的滑動效果
        --    - 特別是跳轉（gg, G, %, 等）時明顯
        --    - 持續時間：50ms
        --
        -- 2. 捲動動畫（scroll）✅
        --    - 使用 <C-d>, <C-u>, <C-f>, <C-b> 時
        --    - 畫面會流暢地捲動而不是瞬間跳轉
        --    - 持續時間：100ms
        --
        -- 【停用的動畫】
        -- 3. 調整視窗大小（resize）❌
        --    - 避免太花俏
        --    - 如果想要可以改 enable = true
        --
        -- 4. 開關視窗（open/close）❌
        --    - 視窗開關有動畫可能太分散注意力
        --    - 如果想要可以改 enable = true
        --
        -- 【使用場景】
        --
        -- 場景 1：大範圍跳轉
        --   游標在第 10 行
        --   按 gg 跳到第 1 行
        --   游標會流暢地滑到頂部 ✨
        --   而不是瞬間消失再出現
        --
        -- 場景 2：捲動瀏覽
        --   按 <C-d> 向下捲動
        --   畫面流暢滾動 ✨
        --   更容易追蹤位置
        --
        -- 場景 3：搜尋跳轉
        --   /pattern 搜尋
        --   按 n 跳到下一個
        --   游標流暢移動到目標 ✨
        --
        -- 【效能注意】
        -- 1. 動畫會消耗一些效能
        -- 2. 在超大檔案中可能稍慢
        -- 3. 如果覺得卡頓，可以：
        --    - 增加 duration（變慢但更流暢）
        --    - 減少 duration（變快但不流暢）
        --    - 關閉動畫（enable = false）
        --
        -- 【自訂動畫】
        --
        -- 改變動畫速度：
        -- timing = animate.gen_timing.linear({ duration = 150 })
        --          數字越大 = 動畫越慢
        --
        -- 改變動畫曲線：
        -- timing = animate.gen_timing.exponential({ ... })
        --          可選：linear, quadratic, cubic, quartic, exponential
        --
        -- 【啟用更多動畫】
        -- 如果你喜歡更多動畫效果：
        -- 1. resize.enable = true  （視窗大小調整動畫）
        -- 2. open.enable = true    （開啟視窗動畫）
        -- 3. close.enable = true   （關閉視窗動畫）
        --
        -- 【停用所有動畫】
        -- 如果覺得動畫太多：
        -- 把這個檔案刪除或改名即可
        --
        -- 或者個別停用：
        -- cursor.enable = false
        -- scroll.enable = false
        --
        -- 【對比】
        -- 沒有動畫：
        --   游標：瞬間移動（可能失去方向感）
        --   捲動：瞬間跳轉（難以追蹤位置）
        --
        -- 有動畫：
        --   游標：流暢滑動（容易看到移動路徑）
        --   捲動：平滑滾動（清楚知道位置）
    end,
}
