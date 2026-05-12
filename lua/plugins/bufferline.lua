-- ============================
-- bufferline.nvim: 現代化標籤頁
-- ============================
-- GitHub: https://github.com/akinsho/bufferline.nvim
-- 功能：提供類似 VSCode 的標籤頁體驗

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,  -- 立即載入，避免 buffer 管理問題
  priority = 1000,  -- 高優先級，在其他插件之前載入
  keys = {
    -- 數字快速跳轉
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "跳到標籤 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "跳到標籤 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "跳到標籤 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "跳到標籤 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "跳到標籤 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "跳到標籤 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "跳到標籤 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "跳到標籤 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "跳到標籤 9" },
    { "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "跳到最後一個標籤" },

    -- Buffer 管理
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "選擇 Buffer" },
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "選擇並關閉 Buffer" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "關閉左側所有標籤" },
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "關閉右側所有標籤" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "關閉其他所有標籤" },
    { "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "釘選/取消釘選 Buffer" },

    -- 移動標籤
    { "<leader>bm", "<cmd>BufferLineMoveNext<cr>", desc = "向右移動標籤" },
    { "<leader>bM", "<cmd>BufferLineMovePrev<cr>", desc = "向左移動標籤" },

    -- 分組
    { "<leader>bg", "<cmd>BufferLineGroupToggle<cr>", desc = "切換分組" },
  },
  opts = {
    options = {
      -- ============================
      -- 基本設置
      -- ============================
      mode = "buffers", -- "tabs" 或 "buffers"
      themable = true,
      numbers = "buffer_id", -- "none" | "ordinal" | "buffer_id" | "both"

      -- ============================
      -- 關閉按鈕
      -- ============================
      close_command = function(bufnr)
        require("mini.bufremove").delete(bufnr, false)
      end,
      right_mouse_command = function(bufnr)
        require("mini.bufremove").delete(bufnr, false)
      end,
      left_mouse_command = "buffer %d", -- 左鍵點擊切換
      middle_mouse_command = nil, -- 中鍵點擊關閉

      -- ============================
      -- 指示器（當前 buffer 標記）
      -- ============================
      indicator = {
        -- icon = "▎", -- 當前 buffer 左側的標記
        style = "underline", -- 'icon' | 'underline' | 'none'
      },

      -- ============================
      -- 圖標設置
      -- ============================
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",

      -- ============================
      -- 顯示設置
      -- ============================
      max_name_length = 18,
      max_prefix_length = 15,
      truncate_names = true,
      tab_size = 20,

      -- ============================
      -- 診斷信息（LSP 錯誤/警告）
      -- ============================
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,

      -- ============================
      -- 自定義過濾器（隱藏特定 buffer）
      -- ============================
      custom_filter = function(buf_number, buf_numbers)
        -- 過濾掉特殊 buffer
        local filetype = vim.bo[buf_number].filetype
        local buftype = vim.bo[buf_number].buftype

        -- 隱藏這些類型
        if filetype == "qf" or buftype == "terminal" or buftype == "quickfix" then
          return false
        end

        return true
      end,

      -- ============================
      -- 顯示功能
      -- ============================
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,

      -- ============================
      -- 持久化設置
      -- ============================
      persist_buffer_sort = true,

      -- ============================
      -- 分隔符
      -- ============================
      separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
      enforce_regular_tabs = false,
      always_show_bufferline = true,

      -- ============================
      -- 滑鼠懸停
      -- ============================
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },

      -- ============================
      -- 排序
      -- ============================
      sort_by = "insert_after_current", -- 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'

      -- ============================
      -- 偏移（為側邊欄留空間）
      -- ============================
      offsets = {
        {
          filetype = "NvimTree",
          text = "檔案總管",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "aerial",
          text = "符號大綱",
          text_align = "center",
          separator = true,
        },
      },

      -- ============================
      -- 分組
      -- ============================
      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          {
            name = "Tests",
            icon = "",
            matcher = function(buf)
              return buf.name:match("%.test") or buf.name:match("%.spec")
            end,
          },
          {
            name = "Docs",
            icon = "",
            matcher = function(buf)
              return buf.name:match("%.md") or buf.name:match("%.txt")
            end,
          },
        },
      },
    },

    -- ============================
    -- 高亮設置
    -- ============================
    highlights = {
      fill                        = { bg = "NONE" },
      background                  = { bg = "NONE" },
      tab                         = { bg = "NONE" },
      tab_selected                = { bg = "NONE" },
      tab_separator               = { bg = "NONE" },
      tab_separator_selected      = { bg = "NONE" },
      tab_close                   = { bg = "NONE" },
      close_button                = { bg = "NONE" },
      close_button_visible        = { bg = "NONE" },
      close_button_selected       = { bg = "NONE" },
      buffer_visible              = { bg = "NONE" },
      buffer_selected             = { bg = "NONE", bold = true, italic = false, fg = { attribute = "fg", highlight = "Function" } },
      numbers                     = { bg = "NONE" },
      numbers_visible             = { bg = "NONE" },
      numbers_selected            = { bg = "NONE", bold = true, fg = { attribute = "fg", highlight = "Function" } },
      diagnostic                  = { bg = "NONE" },
      diagnostic_visible          = { bg = "NONE" },
      diagnostic_selected         = { bg = "NONE" },
      hint                        = { bg = "NONE" },
      hint_visible                = { bg = "NONE" },
      hint_selected               = { bg = "NONE" },
      hint_diagnostic             = { bg = "NONE" },
      hint_diagnostic_visible     = { bg = "NONE" },
      hint_diagnostic_selected    = { bg = "NONE" },
      info                        = { bg = "NONE" },
      info_visible                = { bg = "NONE" },
      info_selected               = { bg = "NONE" },
      info_diagnostic             = { bg = "NONE" },
      info_diagnostic_visible     = { bg = "NONE" },
      info_diagnostic_selected    = { bg = "NONE" },
      warning                     = { bg = "NONE" },
      warning_visible             = { bg = "NONE" },
      warning_selected            = { bg = "NONE" },
      warning_diagnostic          = { bg = "NONE" },
      warning_diagnostic_visible  = { bg = "NONE" },
      warning_diagnostic_selected = { bg = "NONE" },
      error                       = { bg = "NONE" },
      error_visible               = { bg = "NONE" },
      error_selected              = { bg = "NONE" },
      error_diagnostic            = { bg = "NONE" },
      error_diagnostic_visible    = { bg = "NONE" },
      error_diagnostic_selected   = { bg = "NONE" },
      modified                    = { bg = "NONE" },
      modified_visible            = { bg = "NONE" },
      modified_selected           = { bg = "NONE" },
      duplicate                   = { bg = "NONE" },
      duplicate_visible           = { bg = "NONE" },
      duplicate_selected          = { bg = "NONE" },
      separator                   = { bg = "NONE" },
      separator_visible           = { bg = "NONE" },
      separator_selected          = { bg = "NONE" },
      indicator_visible           = { bg = "NONE" },
      indicator_selected          = { bg = "NONE" },
      pick                        = { bg = "NONE" },
      pick_visible                = { bg = "NONE" },
      pick_selected               = { bg = "NONE" },
      offset_separator            = { bg = "NONE" },
      trunc_marker                = { bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- 設置右鍵菜單
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "bufferline",
      callback = function()
        vim.keymap.set("n", "<RightMouse>", function()
          local buf = vim.fn.bufnr()
          require("mini.bufremove").delete(buf, false)
        end, { buffer = true })
      end,
    })
  end,
}
