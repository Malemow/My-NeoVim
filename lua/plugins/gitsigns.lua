-- ============================
-- gitsigns.nvim: Git 變更標記
-- ============================
-- GitHub: https://github.com/lewis6991/gitsigns.nvim
-- 功能：在左側顯示 Git 變更標記、顯示 blame、預覽 diff、stage/unstage 變更

return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",  -- 在讀取檔案前載入
    config = function()
        require("gitsigns").setup({
            -- ============================
            -- 變更標記符號設定
            -- ============================
            signs = {
                add          = { text = "│" },  -- 新增的行
                change       = { text = "│" },  -- 修改的行
                delete       = { text = "_" },  -- 刪除的行
                topdelete    = { text = "‾" },  -- 刪除的行（頂部）
                changedelete = { text = "~" },  -- 修改並刪除的行
                untracked    = { text = "┆" },  -- 未追蹤的檔案
            },

            -- ============================
            -- 顯示設定
            -- ============================
            signcolumn = true,   -- 在左側 sign column 顯示標記
            numhl = false,       -- 不高亮行號
            linehl = false,      -- 不高亮整行
            word_diff = false,   -- 不顯示單字級別的 diff

            -- ============================
            -- 當前行 blame 設定
            -- ============================
            current_line_blame = true,  -- 在當前行顯示 Git blame（誰改了這行）
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",  -- 在行尾顯示
                delay = 500,            -- 延遲 500ms 顯示（避免太快出現干擾）
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

            -- ============================
            -- 其他設定
            -- ============================
            watch_gitdir = {
                interval = 1000,  -- 每秒檢查一次 git 狀態
                follow_files = true,
            },
            attach_to_untracked = true,  -- 在未追蹤的檔案也顯示標記
            sign_priority = 6,           -- 標記優先級
            update_debounce = 100,       -- 更新防抖動時間（毫秒）

            -- ============================
            -- 快捷鍵設定
            -- ============================
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- ============================
                -- 導航（跳轉到變更）
                -- ============================
                -- 跳到下一個變更
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "下一個 Git 變更" })

                -- 跳到上一個變更
                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "上一個 Git 變更" })

                -- ============================
                -- 操作變更（stage/unstage）
                -- ============================
                -- Stage 當前變更（準備 commit）
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage 變更" })
                map("v", "<leader>hs", function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage 選取的變更" })

                -- Unstage 當前變更
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Unstage 變更" })

                -- Reset 當前變更（丟棄變更）
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset 變更" })
                map("v", "<leader>hr", function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Reset 選取的變更" })

                -- Stage 整個檔案
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage 整個檔案" })

                -- Reset 整個檔案（丟棄所有變更）
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset 整個檔案" })

                -- ============================
                -- 預覽和查看
                -- ============================
                -- 預覽當前變更（顯示 diff）
                map("n", "<leader>hp", gs.preview_hunk, { desc = "預覽變更" })

                -- 顯示當前行的完整 blame
                map("n", "<leader>hb", function() gs.blame_line({full=true}) end, { desc = "顯示 Git blame" })

                -- 切換 blame 顯示
                map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "切換 blame 顯示" })

                -- 顯示 diff（與 HEAD 比較）
                map("n", "<leader>hd", gs.diffthis, { desc = "顯示 diff" })

                -- ============================
                -- 文字物件（Text objects）
                -- ============================
                -- 選取變更區塊（在視覺模式或操作模式使用）
                map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "選取 Git 變更區塊" })
            end,
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【視覺化標記】
        -- 左側 sign column 會顯示：
        -- │ (綠色) : 新增的行
        -- │ (黃色) : 修改的行
        -- _ (紅色) : 刪除的行
        --
        -- 【Git Blame】
        -- 在每行末尾會顯示：誰改的、什麼時候改的、commit 訊息
        --
        -- 【快捷鍵】
        -- ]c / [c      : 跳到下一個/上一個變更
        -- <Space>hp    : 預覽當前變更
        -- <Space>hb    : 顯示完整 blame
        -- <Space>hs    : Stage 變更
        -- <Space>hu    : Unstage 變更
        -- <Space>hr    : Reset 變更（丟棄）
        -- <Space>hS    : Stage 整個檔案
        -- <Space>hR    : Reset 整個檔案
        -- <Space>tb    : 切換 blame 顯示開關
        --
        -- 【實用工作流程】
        -- 1. 編輯檔案，左側會顯示變更標記
        -- 2. 按 ]c 跳到下一個變更位置
        -- 3. 按 <Space>hp 預覽這個變更
        -- 4. 按 <Space>hs stage 這個變更
        -- 5. 用 lazygit 完成 commit 和 push
    end,
}
