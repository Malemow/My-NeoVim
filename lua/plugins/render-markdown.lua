-- ============================
-- render-markdown.nvim: Markdown 即時渲染
-- ============================
-- GitHub: https://github.com/MeanderingProgrammer/render-markdown.nvim
-- 功能：直接在 Neovim 中渲染 Markdown，無需外部預覽器

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>md",
            "<cmd>RenderMarkdown toggle<cr>",
            desc = "開關 Markdown 渲染",
        },
    },
    opts = {
        -- ============================
        -- 標題渲染
        -- ============================
        heading = {
            -- 啟用標題渲染
            enabled = true,
            -- 標題圖示
            sign = true,
            -- 標題符號（# ## ### 等）
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            -- 標題背景
            backgrounds = {
                "RenderMarkdownH1Bg",
                "RenderMarkdownH2Bg",
                "RenderMarkdownH3Bg",
                "RenderMarkdownH4Bg",
                "RenderMarkdownH5Bg",
                "RenderMarkdownH6Bg",
            },
            -- 標題前景（文字顏色）
            foregrounds = {
                "RenderMarkdownH1",
                "RenderMarkdownH2",
                "RenderMarkdownH3",
                "RenderMarkdownH4",
                "RenderMarkdownH5",
                "RenderMarkdownH6",
            },
        },

        -- ============================
        -- 代碼塊渲染
        -- ============================
        code = {
            -- 啟用代碼塊渲染
            enabled = true,
            -- 代碼塊符號（```）
            sign = true,
            -- 代碼塊樣式
            style = "full",  -- full, normal, language
            -- 左側填充
            left_pad = 0,
            -- 右側填充
            right_pad = 0,
            -- 寬度：full（填滿）或數字
            width = "full",
            -- 代碼塊邊框
            border = "thin",  -- thin, thick
            -- 顯示語言標籤
            language_pad = 0,
            -- 高亮語言名稱
            highlight = "RenderMarkdownCode",
            highlight_inline = "RenderMarkdownCodeInline",
        },

        -- ============================
        -- 破折號（Dash）渲染
        -- ============================
        dash = {
            enabled = true,
            icon = "─",
            highlight = "RenderMarkdownDash",
        },

        -- ============================
        -- 項目符號（Bullet）渲染
        -- ============================
        bullet = {
            enabled = true,
            -- 不同層級的符號
            icons = { "●", "○", "◆", "◇" },
            highlight = "RenderMarkdownBullet",
        },

        -- ============================
        -- 複選框（Checkbox）渲染
        -- ============================
        checkbox = {
            enabled = true,
            unchecked = {
                icon = "󰄱 ",
                highlight = "RenderMarkdownUnchecked",
            },
            checked = {
                icon = "󰱒 ",
                highlight = "RenderMarkdownChecked",
            },
            custom = {
                todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
            },
        },

        -- ============================
        -- 引用（Quote）渲染
        -- ============================
        quote = {
            enabled = true,
            icon = "▋",
            highlight = "RenderMarkdownQuote",
        },

        -- ============================
        -- 表格（Table）渲染
        -- ============================
        pipe_table = {
            enabled = true,
            style = "full",  -- full, normal, none
            cell = "padded",  -- padded, raw
            border = {
                "┌", "┬", "┐",
                "├", "┼", "┤",
                "└", "┴", "┘",
                "│", "─",
            },
            head = "RenderMarkdownTableHead",
            row = "RenderMarkdownTableRow",
        },

        -- ============================
        -- Callout（提示框）渲染
        -- ============================
        callout = {
            note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
            tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
            important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
            warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
            caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
        },

        -- ============================
        -- 連結（Link）渲染
        -- ============================
        link = {
            enabled = true,
            -- 連結圖示
            image = "󰥶 ",
            hyperlink = "󰌹 ",
            highlight = "RenderMarkdownLink",
        },

        -- ============================
        -- 其他設定
        -- ============================
        sign = {
            enabled = true,
            highlight = "RenderMarkdownSign",
        },

        -- 最小視窗寬度（小於此寬度不渲染）
        min_width = 0,

        -- 渲染模式
        render_modes = { "n", "c" },  -- normal, command 模式渲染
    },
    config = function(_, opts)
        require("render-markdown").setup(opts)

        -- ============================
        -- 使用說明
        -- ============================
        -- 【快捷鍵】
        -- <Space>md    : 開關 Markdown 渲染
        --
        -- 【命令】
        -- :RenderMarkdown toggle   : 開關渲染
        -- :RenderMarkdown enable   : 啟用渲染
        -- :RenderMarkdown disable  : 禁用渲染
        --
        -- 【功能】
        -- 1. 標題美化
        --    # 大標題      → 󰲡  大標題（帶背景色）
        --    ## 中標題     → 󰲣  中標題
        --    ### 小標題    → 󰲥  小標題
        --
        -- 2. 代碼塊渲染
        --    ```lua
        --    print("Hello")
        --    ```
        --    → 顯示語言標籤、邊框、語法高亮
        --
        -- 3. 列表美化
        --    - 項目 1      → ● 項目 1
        --      - 子項目    → ○ 子項目
        --    - [x] 完成    → 󰱒  完成
        --    - [ ] 未完成  → 󰄱  未完成
        --
        -- 4. 表格美化
        --    | 標題 | 內容 |
        --    |------|------|
        --    | A    | B    |
        --    → 顯示完整邊框的表格
        --
        -- 5. 引用美化
        --    > 這是引用
        --    → ▋ 這是引用
        --
        -- 6. 連結美化
        --    [文字](URL)      → 󰌹  文字
        --    ![圖片](URL)     → 󰥶  圖片
        --
        -- 7. Callout（GitHub 風格提示框）
        --    > [!NOTE]
        --    > 這是提示
        --    → 󰋽 Note
        --      這是提示
        --
        -- 【支援的 Callout 類型】
        -- [!NOTE]      - 󰋽 藍色提示
        -- [!TIP]       - 󰌶 綠色技巧
        -- [!IMPORTANT] - 󰅾 紫色重要
        -- [!WARNING]   - 󰀪 黃色警告
        -- [!CAUTION]   - 󰳦 紅色注意
        --
        -- 【與 markdown-preview 的區別】
        -- render-markdown.nvim:
        --   - 直接在編輯器內渲染
        --   - 無需外部瀏覽器
        --   - 適合快速查看和編輯
        --   - 輕量級
        --
        -- markdown-preview.nvim:
        --   - 在瀏覽器中預覽
        --   - 完整的 HTML 渲染
        --   - 支援複雜圖表（Mermaid、PlantUML）
        --   - 適合最終預覽
        --
        -- 【推薦工作流程】
        -- 1. 編輯時：使用 render-markdown 即時查看格式
        -- 2. 完成後：使用 markdown-preview 查看最終效果
        -- 3. 兩者可同時使用，互不衝突
        --
        -- 【自訂顏色】
        -- 可在主題中自訂以下高亮組：
        -- - RenderMarkdownH1 ~ H6: 標題顏色
        -- - RenderMarkdownCode: 代碼塊背景
        -- - RenderMarkdownBullet: 項目符號
        -- - RenderMarkdownChecked/Unchecked: 複選框
        -- - RenderMarkdownQuote: 引用
        -- - RenderMarkdownLink: 連結
        --
        -- 【注意事項】
        -- 1. 只在 normal 和 command 模式渲染
        -- 2. 插入模式會顯示原始 Markdown 語法（方便編輯）
        -- 3. 需要 Nerd Font 字型才能正確顯示圖示
        -- 4. 依賴 TreeSitter 的 Markdown parser
    end,
}
