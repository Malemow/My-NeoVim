-- ============================
-- mini.comment: 快速註解/取消註解
-- ============================
-- GitHub: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
-- 功能：快速註解程式碼行或區塊

return {
    "echasnovski/mini.comment",
    version = "*",  -- 使用穩定版本
    config = function()
        require("mini.comment").setup({
            -- ============================
            -- 快捷鍵設定
            -- ============================
            options = {
                -- 自動偵測註解符號（根據檔案類型）
                -- 例如：
                -- - Lua 使用 --
                -- - Python 使用 #
                -- - JavaScript 使用 //
                -- - HTML 使用 <!-- -->
                custom_commentstring = nil,
            },
            mappings = {
                -- 普通模式：註解/取消註解當前行
                comment_line = "gcc",

                -- 普通模式：註解/取消註解多行（需配合 motion）
                comment = "gc",

                -- 視覺模式：註解/取消註解選取區域
                comment_visual = "gc",
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【普通模式 (Normal mode)】
        -- gcc       : 註解/取消註解當前行
        --             例如：在程式碼行上按 gcc 會變成註解，再按一次會取消註解
        --
        -- gc + motion : 註解多行（配合 Vim motion）
        --             gcap : 註解整個段落 (paragraph)
        --             gc2j : 註解當前行和下面兩行
        --             gcG  : 從當前行註解到檔案結尾
        --
        -- 【視覺模式 (Visual mode)】
        -- gc        : 註解/取消註解選取的區域
        --             步驟：
        --             1. 按 V 或 Shift+V 進入視覺模式
        --             2. 用 j/k 選取要註解的行
        --             3. 按 gc 就會全部註解
        --
        -- 【實用範例】
        -- 1. 快速註解當前行：
        --    游標在程式碼行 → 按 gcc → 變成註解
        --
        -- 2. 註解一整個函式：
        --    游標在函式內 → 按 gcip (comment inside paragraph)
        --
        -- 3. 註解選取區域：
        --    視覺模式選取多行 → 按 gc → 全部變成註解
        --
        -- 4. 取消註解：
        --    在已註解的行上，再按一次 gcc 或 gc 即可取消
    end,
}
