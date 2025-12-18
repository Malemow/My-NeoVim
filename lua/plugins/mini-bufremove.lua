-- ============================
-- mini.bufremove: 智能 buffer 刪除
-- ============================
-- GitHub: https://github.com/echasnovski/mini.bufremove
-- 功能：刪除 buffer 時保留視窗佈局

return {
    "echasnovski/mini.bufremove",
    version = false,
    keys = {
        {
            "<leader>q",
            function()
                require("mini.bufremove").delete(0, false)
            end,
            desc = "關閉當前 buffer",
        },
        {
            "<leader>Q",
            function()
                require("mini.bufremove").delete(0, true)
            end,
            desc = "強制關閉 buffer（不儲存）",
        },
    },
    config = function()
        require("mini.bufremove").setup({
            -- ============================
            -- 設定選項
            -- ============================
            -- 設定視窗顯示的訊息（當沒有其他 buffer 可顯示時）
            set_vim_settings = true,

            -- 靜默模式（不顯示刪除訊息）
            silent = false,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本概念】
        -- 一般的 :bd (buffer delete) 會刪除 buffer 並關閉視窗
        -- mini.bufremove 會刪除 buffer 但保留視窗，並自動顯示下一個 buffer
        --
        -- 【快捷鍵】（在本檔案的 keys 中定義）
        -- <Space>q     : 刪除當前 buffer（保留視窗）
        -- <Space>Q     : 強制刪除當前 buffer（保留視窗，不儲存）
        --
        -- 【使用情境】
        --
        -- 情境 1：多視窗工作
        -- ┌──────────┬──────────┐
        -- │ file1.js │ file2.js │
        -- └──────────┴──────────┘
        -- 在 file2.js 按 <Space>q
        -- → file2.js 關閉，但右邊視窗保留，顯示下一個 buffer
        --
        -- 情境 2：參考文檔
        -- ┌──────────┬──────────┐
        -- │ code.js  │ docs.md  │
        -- └──────────┴──────────┘
        -- 看完 docs.md 按 <Space>q
        -- → docs.md 關閉，右邊視窗保留，自動顯示其他檔案
        --
        -- 情境 3：臨時開啟多個檔案
        -- 用 Telescope 開了 10 個檔案做參考
        -- 現在想清理不需要的檔案
        -- → 用 <Space>q 逐個關閉，視窗佈局不會被破壞
        --
        -- 【進階功能】
        --
        -- 手動呼叫：
        -- :lua require('mini.bufremove').delete()      -- 刪除當前 buffer
        -- :lua require('mini.bufremove').delete(0, true)  -- 強制刪除
        -- :lua require('mini.bufremove').delete(5)     -- 刪除 buffer 編號 5
        --
        -- 在 Lua 中使用：
        -- local bufremove = require('mini.bufremove')
        -- bufremove.delete()           -- 刪除當前
        -- bufremove.delete(0, true)    -- 強制刪除當前
        -- bufremove.wipeout()          -- 完全清除 buffer（包括歷史）
        --
        -- 【與 tabline 搭配使用】
        -- 你的 mini.tabline 會顯示所有 buffer：
        -- [file1] [file2] [file3] [file4]
        --
        -- 當你刪除 file2 時：
        -- - Tabline 會移除 [file2]
        -- - 視窗會自動顯示 file3（下一個可用的 buffer）
        -- - 視窗佈局完全不變
        --
        -- 【注意事項】
        -- 1. 如果 buffer 有未儲存的修改，會提示你儲存
        -- 2. 使用 <Space>Q 可以強制刪除（不儲存）
        -- 3. 如果是最後一個 buffer，會顯示空 buffer（不會關閉 Vim）
        -- 4. 配合 mini.tabline 使用效果最佳
        --
        -- 【對比】
        -- 預設 :bd               vs   mini.bufremove
        -- ─────────────────────────────────────────────
        -- 刪除 buffer + 關閉視窗  vs   刪除 buffer + 保留視窗
        -- 破壞視窗佈局           vs   保持視窗佈局
        -- 需要重新分割           vs   自動顯示下一個 buffer
    end,
}
