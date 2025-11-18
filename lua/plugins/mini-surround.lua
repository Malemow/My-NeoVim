-- ============================
-- mini.surround: 快速編輯包圍字元
-- ============================
-- GitHub: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
-- 功能：新增、刪除、替換、尋找包圍文字的括號、引號、標籤等

return {
    "echasnovski/mini.surround",
    version = "*",  -- 使用穩定版本
    config = function()
        require("mini.surround").setup({
            -- ============================
            -- 快捷鍵設定
            -- ============================
            mappings = {
                add = "sa",            -- 新增包圍（Surround Add）
                delete = "sd",         -- 刪除包圍（Surround Delete）
                find = "sf",           -- 尋找右側包圍（Surround Find）
                find_left = "sF",      -- 尋找左側包圍（Surround Find left）
                highlight = "sh",      -- 高亮包圍範圍（Surround Highlight）
                replace = "sr",        -- 替換包圍（Surround Replace）
                update_n_lines = "sn", -- 更新搜尋範圍（往下 n 行）
            },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【新增包圍 (sa)】
        -- sa + 範圍 + 包圍符號
        --
        -- 範例：
        -- 1. saiw"  : 將游標所在單字用雙引號包圍
        --    hello  →  "hello"
        --
        -- 2. saiw(  : 將游標所在單字用括號包圍
        --    hello  →  (hello)
        --
        -- 3. saiw)  : 將游標所在單字用括號包圍（無空格）
        --    hello  →  (hello)
        --
        -- 4. sa2w]  : 將接下來兩個單字用方括號包圍
        --    hello world  →  [hello world]
        --
        -- 5. 視覺模式：選取文字後按 sa"  →  用雙引號包圍選取區域
        --
        -- 【刪除包圍 (sd)】
        -- sd + 包圍符號
        --
        -- 範例：
        -- 1. sd"    : 刪除雙引號
        --    "hello"  →  hello
        --
        -- 2. sd(    : 刪除括號（會自動找最近的括號）
        --    (hello)  →  hello
        --
        -- 3. sd]    : 刪除方括號
        --    [hello]  →  hello
        --
        -- 4. sdt    : 刪除 HTML/XML 標籤
        --    <div>hello</div>  →  hello
        --
        -- 【替換包圍 (sr)】
        -- sr + 舊包圍符號 + 新包圍符號
        --
        -- 範例：
        -- 1. sr"'   : 將雙引號替換成單引號
        --    "hello"  →  'hello'
        --
        -- 2. sr([   : 將圓括號替換成方括號
        --    (hello)  →  [hello]
        --
        -- 3. sr)]   : 將圓括號替換成方括號
        --    (hello)  →  [hello]
        --
        -- 【常用包圍符號】
        -- " ' ` ( ) [ ] { } < > t (HTML 標籤)
        --
        -- 【實用技巧】
        -- 1. 快速將單字加上引號：游標在單字上 → saiw"
        -- 2. 將引號改成括號：sr"(
        -- 3. 移除括號：sd(
        -- 4. 包圍整行：sa$)  或  0sa$)
    end,
}
