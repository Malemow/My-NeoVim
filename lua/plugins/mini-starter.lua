-- ============================
-- mini.starter: 啟動畫面
-- ============================
-- GitHub: https://github.com/echasnovski/mini.starter
-- 功能：美化的 Neovim 啟動畫面

return {
    "echasnovski/mini.starter",
    version = false,
    config = function()
        local starter = require("mini.starter")

        starter.setup({
            -- ============================
            -- 內容設定
            -- ============================
            items = {
                -- 最近檔案
                starter.sections.recent_files(5, false),

                -- 最近開啟的檔案（在當前目錄）
                starter.sections.recent_files(5, true),

                -- 內建動作
                starter.sections.builtin_actions(),
            },

            -- ============================
            -- 內容鉤子
            -- ============================
            content_hooks = {
                -- 添加標題和底部
                starter.gen_hook.adding_bullet("│ ", false),
                starter.gen_hook.aligning("center", "center"),
            },

            -- ============================
            -- 標題
            -- ============================
            header = function()
                local hour = tonumber(vim.fn.strftime("%H"))
                local greeting = ""

                if hour < 6 then
                    greeting = "  深夜了，早點休息！"
                elseif hour < 12 then
                    greeting = "  早安！開始美好的一天"
                elseif hour < 18 then
                    greeting = "  午安！繼續加油"
                else
                    greeting = "  晚安！辛苦了"
                end

                return greeting .. "\n\n"
                    .. "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗\n"
                    .. "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║\n"
                    .. "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║\n"
                    .. "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║\n"
                    .. "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║\n"
                    .. "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\n"
            end,

            -- ============================
            -- 底部
            -- ============================
            footer = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return "\n⚡ Neovim 載入時間：" .. ms .. " ms  |  已安裝 " .. stats.count .. " 個插件"
            end,

            -- ============================
            -- 視窗設定
            -- ============================
            query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

            -- ============================
            -- 自動退出設定
            -- ============================
            -- 開啟檔案後自動關閉啟動畫面
            autoopen = true,
        })

        -- ============================
        -- 自動開啟設定
        -- ============================
        -- 只在無參數啟動時顯示啟動畫面
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                -- 如果有開啟檔案，不顯示啟動畫面
                if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
                    require("mini.starter").open()
                end
            end,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【顯示時機】
        -- 1. 執行 nvim（不帶任何檔案參數）
        -- 2. 會顯示啟動畫面
        --
        -- 【啟動畫面內容】
        -- 1. 問候語（根據時間自動變化）
        -- 2. Neovim ASCII 藝術字
        -- 3. 最近開啟的檔案（全域）
        -- 4. 最近開啟的檔案（當前目錄）
        -- 5. 內建動作（開新檔案、退出等）
        -- 6. 載入時間和插件數量
        --
        -- 【操作方式】
        -- - 項目前面有字母或數字標記
        -- - 按對應的鍵就能開啟該檔案或執行動作
        -- - 按 q 退出啟動畫面
        -- - 按 i 進入普通編輯模式
        --
        -- 【範例畫面】
        -- ┌─────────────────────────────────────┐
        -- │    早安！開始美好的一天              │
        -- │                                     │
        -- │    ███╗   ██╗███████╗ ...          │
        -- │                                     │
        -- │  最近開啟的檔案：                   │
        -- │  a │ ~/project/index.js             │
        -- │  b │ ~/project/App.vue              │
        -- │                                     │
        -- │  動作：                             │
        -- │  e │ 開新檔案                       │
        -- │  q │ 退出                           │
        -- │                                     │
        -- │  ⚡ 載入時間：12.3 ms  |  25 個插件  │
        -- └─────────────────────────────────────┘
        --
        -- 【自訂】
        -- 可以修改 header 和 footer 函式來自訂內容
        -- 可以修改 items 來改變顯示的項目
        --
        -- 【手動開啟】
        -- :Starter
        --
        -- 【禁用】
        -- 如果不想要啟動畫面：
        -- 把這個檔案刪除或改名即可
    end,
}
