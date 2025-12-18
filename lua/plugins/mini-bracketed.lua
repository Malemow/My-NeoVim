-- ============================
-- mini.bracketed: [] 導航增強
-- ============================
-- GitHub: https://github.com/echasnovski/mini.bracketed
-- 功能：提供統一的 [] 導航系統，擴展 Vim 原生的導航功能

return {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
        require("mini.bracketed").setup({
            -- ============================
            -- 啟用的導航類型
            -- ============================
            -- 每個類型都可以設定為 true/false 或自訂選項

            -- Buffer 導航
            buffer = { suffix = "b", options = {} },

            -- 註解區塊導航
            comment = { suffix = "o", options = {} },

            -- 衝突標記導航（Git merge conflicts）
            -- 已禁用，因為 [x/]x 用於 Trouble 問題導航
            conflict = { suffix = "", options = {} },

            -- 診斷導航
            diagnostic = { suffix = "d", options = {} },

            -- 檔案導航（在目錄中的上/下一個檔案）⭐ 超實用
            file = { suffix = "f", options = {} },

            -- 縮排變化導航
            indent = { suffix = "i", options = {} },

            -- 跳轉歷史導航
            jump = { suffix = "j", options = {} },

            -- Location list 導航
            location = { suffix = "l", options = {} },

            -- 舊檔案導航（最近開啟的檔案）
            oldfile = { suffix = "o", options = {} },

            -- Quickfix 導航
            quickfix = { suffix = "q", options = {} },

            -- Tree-sitter 節點導航
            treesitter = { suffix = "t", options = {} },

            -- Undo 狀態導航
            undo = { suffix = "u", options = {} },

            -- 視窗導航
            window = { suffix = "w", options = {} },

            -- Yank（複製）歷史導航
            yank = { suffix = "y", options = {} },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【基本概念】
        -- mini.bracketed 提供統一的 [] 導航系統
        -- 格式：[{suffix} 或 ]{suffix}
        -- [ = 上一個，] = 下一個
        --
        -- 【所有可用的導航】
        --
        -- === Buffer 和檔案 ===
        -- [b / ]b      : 上/下一個 buffer（你已經有的）
        -- [f / ]f      : 上/下一個檔案（在當前目錄中）⭐
        -- [o / ]o      : 上/下一個舊檔案（最近開啟的）
        --
        -- === 程式碼導航 ===
        -- [d / ]d      : 上/下一個診斷（錯誤/警告）（你已經有的）
        -- [c / ]c      : 上/下一個 Git 變更（你已經有的）
        -- [i / ]i      : 上/下一個縮排變化
        -- [t / ]t      : 上/下一個 Tree-sitter 節點
        -- [o / ]o      : 上/下一個註解區塊
        -- [x / ]x      : 上/下一個衝突標記（Git merge）
        --
        -- === 列表和歷史 ===
        -- [q / ]q      : 上/下一個 quickfix 項目
        -- [l / ]l      : 上/下一個 location list 項目
        -- [j / ]j      : 上/下一個跳轉位置（跳轉歷史）
        -- [u / ]u      : 上/下一個 undo 狀態
        -- [y / ]y      : 上/下一個 yank（複製歷史）
        --
        -- === 視窗管理 ===
        -- [w / ]w      : 上/下一個視窗
        --
        -- 【實用場景】
        --
        -- 場景 1：瀏覽目錄中的檔案
        --   你在 src/components/Button.vue
        --   按 ]f → 跳到 Card.vue
        --   按 ]f → 跳到 Footer.vue
        --   按 [f → 回到 Card.vue
        --   不用開檔案樹！
        --
        -- 場景 2：快速切換視窗
        --   你有 3 個分割視窗
        --   按 ]w → 下一個視窗
        --   按 [w → 上一個視窗
        --   比 <C-w>w 更直覺
        --
        -- 場景 3：查看 Telescope 搜尋結果
        --   用 Telescope 搜尋後
        --   按 ]q → 下一個搜尋結果
        --   按 [q → 上一個搜尋結果
        --   不用重新開 Telescope
        --
        -- 場景 4：在函式間跳轉
        --   按 ]t → 下一個 Tree-sitter 節點（函式、類別等）
        --   按 [t → 上一個節點
        --
        -- 場景 5：Git merge 衝突
        --   檔案有 merge conflict
        --   按 ]x → 跳到下一個衝突標記
        --   解決衝突後，按 ]x 繼續下一個
        --
        -- 場景 6：跳轉歷史
        --   你跳來跳去好幾次（gd, gr 等）
        --   按 [j → 回到之前的位置
        --   按 ]j → 前往下一個位置
        --   類似瀏覽器的上一頁/下一頁
        --
        -- 場景 7：Undo 歷史
        --   按 [u → 回到上一個 undo 狀態
        --   按 ]u → 前往下一個 undo 狀態（redo）
        --
        -- 【首次移動 vs 最後移動】
        -- 很多導航支援「首次」和「最後」：
        -- [B（大寫）: 第一個 buffer
        -- ]B（大寫）: 最後一個 buffer
        -- 同理：[F ]F（首/尾檔案）、[Q ]Q（首/尾 quickfix）等
        --
        -- 【最常用的（推薦記住）】
        -- ]f / [f      : 下/上一個檔案 ⭐⭐⭐⭐⭐
        -- ]w / [w      : 下/上一個視窗 ⭐⭐⭐⭐
        -- ]q / [q      : 下/上一個 quickfix ⭐⭐⭐⭐
        -- ]j / [j      : 跳轉歷史 ⭐⭐⭐⭐
        -- ]x / [x      : Git 衝突標記 ⭐⭐⭐
        --
        -- 【與現有快捷鍵的關係】
        -- 你已經有的：
        -- [b ]b        : buffer 導航（保持不變）
        -- [d ]d        : 診斷導航（保持不變）
        -- [c ]c        : Git 變更導航（保持不變）
        -- [i ]i        : 縮排範圍導航（mini.indentscope）
        --
        -- mini.bracketed 新增：
        -- [f ]f        : 檔案導航 ⭐ 新增
        -- [w ]w        : 視窗導航 ⭐ 新增
        -- [q ]q        : quickfix ⭐ 新增
        -- [l ]l        : location list ⭐ 新增
        -- [j ]j        : 跳轉歷史 ⭐ 新增
        -- [u ]u        : undo 歷史 ⭐ 新增
        -- [y ]y        : yank 歷史 ⭐ 新增
        -- [t ]t        : Tree-sitter 節點 ⭐ 新增
        -- [o ]o        : 註解/舊檔案 ⭐ 新增
        -- [x ]x        : 衝突標記 ⭐ 新增
        --
        -- 【注意】
        -- 有些快捷鍵可能和其他插件衝突
        -- 如果遇到衝突，可以在上面的 setup 中設為 false 關閉
        -- 例如：comment = false,  -- 關閉註解導航
    end,
}
