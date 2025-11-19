-- ============================
-- nvim-ts-autotag: 自動關閉 HTML/JSX/Vue 標籤
-- ============================
-- GitHub: https://github.com/windwp/nvim-ts-autotag
-- 功能：寫 <div> 會自動補 </div>，重新命名時也會同步更新

return {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-ts-autotag").setup({
            -- ============================
            -- 選項設定
            -- ============================
            opts = {
                -- 啟用自動關閉標籤
                enable_close = true,

                -- 啟用自動重新命名標籤
                enable_rename = true,

                -- 啟用自動關閉 slash（<br />）
                enable_close_on_slash = false,
            },

            -- ============================
            -- 每個檔案類型的設定
            -- ============================
            -- 如果需要自訂特定檔案類型的行為，可以在這裡設定
            -- per_filetype = {
            --     ["html"] = {
            --         enable_close = false,
            --     },
            -- },
        })

        -- ============================
        -- 使用說明
        -- ============================
        -- 【自動關閉標籤】
        -- 輸入：<div>
        -- 結果：<div>|</div>  （游標在中間）
        --
        -- 【自動重新命名】
        -- 1. 將 <div> 改成 <section>
        -- 2. 對應的 </div> 會自動變成 </section>
        --
        -- 【支援的檔案類型】
        -- - HTML (.html)
        -- - JavaScript/TypeScript (.js, .jsx, .ts, .tsx)
        -- - Vue (.vue)
        -- - XML (.xml)
        -- - PHP (.php)
        -- - 等等...
        --
        -- 【注意事項】
        -- - 需要 Treesitter 支援對應的語言
        -- - 確保你已經安裝了對應語言的 Treesitter parser
        --   （例如：:TSInstall html javascript tsx vue）
        --
        -- 【範例】
        -- HTML:
        --   <div>  → <div>|</div>
        --   <img   → <img />  （自閉合標籤）
        --
        -- JSX/TSX:
        --   <Button>  → <Button>|</Button>
        --   <MyComponent  → <MyComponent />
        --
        -- Vue:
        --   <template>  → <template>|</template>
        --   <div class="container">  → <div class="container">|</div>
    end,
}
