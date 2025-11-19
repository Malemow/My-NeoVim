-- ============================
-- marks.nvim: 標記管理增強
-- ============================
-- GitHub: https://github.com/chentoast/marks.nvim
-- 功能：可視化顯示和管理 Vim 標記，讓標記功能更好用

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  keys = {
    {
      "m,",
      "<cmd>MarksListAll<cr>",
      desc = "列出所有標記",
    },
    {
      "m;",
      "<cmd>MarksListBuf<cr>",
      desc = "列出當前 buffer 的標記",
    },
    {
      "dm",
      function()
        -- 刪除當前行的所有標記
        vim.cmd("delmarks!")
      end,
      desc = "刪除當前 buffer 所有標記",
    },
  },
  opts = {
    -- 預設標記（a-z 本地標記，A-Z 全局標記）
    default_mappings = true,

    -- 顯示內建標記（', ^, ., etc）
    builtin_marks = { ".", "<", ">", "^" },

    -- 是否循環使用標記（當標記滿時自動覆蓋最舊的）
    cyclic = true,

    -- 強制寫入 shada（保存標記歷史）
    force_write_shada = false,

    -- 刷新間隔（毫秒）
    refresh_interval = 250,

    -- Sign 圖標配置（顯示在左側欄）
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

    -- 排除的文件類型
    excluded_filetypes = {
      "qf",
      "NvimTree",
      "toggleterm",
      "TelescopePrompt",
      "aerial",
      "trouble",
    },

    -- 標記組/書籤配置
    bookmark_0 = {
      sign = "⚑",
      virt_text = "重要",
      annotate = false,
    },

    -- 映射設置
    mappings = {
      -- 設置標記（預設 m + 字母）
      set = "m",

      -- 刪除當前行的標記
      delete_line = "dm-",

      -- 刪除當前 buffer 的所有標記
      delete_buf = "dm=",

      -- 跳到下一個標記
      next = "m]",

      -- 跳到上一個標記
      prev = "m[",

      -- 預覽標記
      preview = "m:",

      -- 設置書籤（可以有描述）
      set_next = "m,",

      -- 切換標記
      toggle = "m;",

      -- 刪除所有書籤
      delete_bookmark = "dm<space>",
    },
  },
  config = function(_, opts)
    require("marks").setup(opts)

    -- 自定義高亮
    vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#61AFEF", bold = true })
    vim.api.nvim_set_hl(0, "MarkVirtTextHL", { fg = "#ABB2BF", italic = true })

    -- 創建用戶命令
    vim.api.nvim_create_user_command("MarksListAll", function()
      require("marks").mark_state:all_to_list("all")
    end, { desc = "列出所有標記" })

    vim.api.nvim_create_user_command("MarksListBuf", function()
      require("marks").mark_state:buffer_to_list(0)
    end, { desc = "列出當前 buffer 的標記" })

    vim.api.nvim_create_user_command("MarksClearBuf", function()
      vim.cmd("delmarks!")
      vim.notify("已清除當前 buffer 的所有標記", vim.log.levels.INFO)
    end, { desc = "清除當前 buffer 的所有標記" })

    vim.api.nvim_create_user_command("MarksClearAll", function()
      vim.cmd("delmarks A-Z0-9")
      vim.notify("已清除所有全局標記", vim.log.levels.INFO)
    end, { desc = "清除所有全局標記" })
  end,
}
