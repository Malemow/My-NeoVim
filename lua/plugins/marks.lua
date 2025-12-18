-- ============================
-- marks.nvim: 標記管理增強
-- ============================
-- GitHub: https://github.com/chentoast/marks.nvim
-- 功能：可視化顯示和管理 Vim 標記，讓標記功能更好用

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  keys = {
    -- 使用 leader 鍵避免與默認快捷鍵衝突
    { "<leader>ml", "<cmd>MarksListBuf<cr>", desc = "列出 buffer 標記" },
    { "<leader>mL", "<cmd>MarksListGlobal<cr>", desc = "列出全局標記" },
    { "<leader>mb", "<cmd>BookmarksListAll<cr>", desc = "列出所有書籤" },
    { "<leader>m0", "<cmd>BookmarksList 0<cr>", desc = "列出 [重要] 書籤" },
    { "<leader>m1", "<cmd>BookmarksList 1<cr>", desc = "列出 [待辦] 書籤" },
    { "<leader>m2", "<cmd>BookmarksList 2<cr>", desc = "列出 [完成] 書籤" },
    { "<leader>m3", "<cmd>BookmarksList 3<cr>", desc = "列出 [問題] 書籤" },
    { "<leader>m4", "<cmd>BookmarksList 4<cr>", desc = "列出 [重點] 書籤" },
    { "<leader>mt", "<cmd>MarksToggleSigns<cr>", desc = "切換標記顯示" },
  },
  opts = {
    -- 啟用預設快捷鍵
    -- mx: 設置標記 x
    -- m,: 設置下一個可用的小寫標記
    -- m;: 切換下一個可用標記
    -- dmx: 刪除標記 x
    -- dm-: 刪除當前行標記
    -- dm<space>: 清除 buffer 所有標記
    -- m]: 下一個標記
    -- m[: 上一個標記
    -- m:: 預覽標記
    default_mappings = true,

    -- 顯示內建標記
    builtin_marks = { ".", "<", ">", "^" },

    -- 循環導航（到達最後一個標記後回到第一個）
    cyclic = true,

    -- 強制寫入 shada（保存標記歷史）
    force_write_shada = false,

    -- 刷新間隔（毫秒）- 使用推薦值
    refresh_interval = 150,

    -- Sign 優先級配置
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

    -- 排除的文件類型
    excluded_filetypes = {
      "qf",
      "NvimTree",
      "toggleterm",
      "TelescopePrompt",
      "aerial",
      "trouble",
      "lazy",
      "mason",
    },

    -- 書籤配置（0-9 共 10 組）
    -- 每組可配置不同顏色、圖標和標註文字
    bookmark_0 = {
      sign = "⚑",
      virt_text = "重要",
      annotate = false,
      -- 紅色：重要事項
      highlight = "DiagnosticError",
    },
    bookmark_1 = {
      sign = "⚐",
      virt_text = "待辦",
      annotate = false,
      -- 黃色：待處理
      highlight = "DiagnosticWarn",
    },
    bookmark_2 = {
      sign = "✓",
      virt_text = "完成",
      annotate = false,
      -- 綠色：已完成
      highlight = "DiagnosticOk",
    },
    bookmark_3 = {
      sign = "✗",
      virt_text = "問題",
      annotate = false,
      -- 橙色：需要注意
      highlight = "DiagnosticHint",
    },
    bookmark_4 = {
      sign = "★",
      virt_text = "重點",
      annotate = false,
      -- 藍色：資訊標記
      highlight = "DiagnosticInfo",
    },
  },
  config = function(_, opts)
    require("marks").setup(opts)

    -- 自定義書籤高亮組（可選，提供更細緻的顏色控制）
    local set_hl = vim.api.nvim_set_hl

    -- 重要（紅色系）
    set_hl(0, "MarkSign0", { fg = "#ff5555", bold = true })
    -- 待辦（黃色系）
    set_hl(0, "MarkSign1", { fg = "#f1fa8c", bold = true })
    -- 完成（綠色系）
    set_hl(0, "MarkSign2", { fg = "#50fa7b", bold = true })
    -- 問題（橙色系）
    set_hl(0, "MarkSign3", { fg = "#ffb86c", bold = true })
    -- 重點（藍色系）
    set_hl(0, "MarkSign4", { fg = "#8be9fd", bold = true })

    -- 虛擬文字顏色（標註文字）
    set_hl(0, "MarkVirtText0", { fg = "#ff5555", italic = true })
    set_hl(0, "MarkVirtText1", { fg = "#f1fa8c", italic = true })
    set_hl(0, "MarkVirtText2", { fg = "#50fa7b", italic = true })
    set_hl(0, "MarkVirtText3", { fg = "#ffb86c", italic = true })
    set_hl(0, "MarkVirtText4", { fg = "#8be9fd", italic = true })
  end,
}
