-- ============================
-- snacks.nvim: 實用小工具集合
-- ============================
-- GitHub: https://github.com/folke/snacks.nvim
-- 功能：提供多種小型實用工具，是 claudecode.nvim 的依賴

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- 啟用 terminal 支援（claudecode 需要）
    terminal = { enabled = true },
    -- 其他可選功能
    notifier = { enabled = false },  -- 通知系統（你已經有 noice.nvim）
    bigfile = { enabled = true },    -- 大文件優化
    quickfile = { enabled = true },  -- 快速檔案載入
    statuscolumn = { enabled = false }, -- 狀態欄（你已經有 statuscol.nvim）
    words = { enabled = false },     -- 單詞高亮（你已經有 mini.cursorword）
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
