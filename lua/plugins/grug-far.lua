-- ============================
-- grug-far.nvim: 搜尋與替換
-- ============================
-- GitHub: https://github.com/MagicDuck/grug-far.nvim
-- 功能：現代化的全局搜尋和替換工具，支援浮動視窗

return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>R",
      function()
        require("grug-far").open()
      end,
      desc = "打開 Grug-far（全局搜尋替換）",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "替換當前單詞（Grug-far）",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = "v",
      desc = "替換選取內容（Grug-far）",
    },
    {
      "<leader>rf",
      function()
        require("grug-far").open({
          prefills = { paths = vim.fn.expand("%") },
        })
      end,
      desc = "在當前文件替換（Grug-far）",
    },
  },
  opts = {
    -- ============================
    -- 視窗設置（浮動視窗）
    -- ============================
    windowCreationCommand = "tabnew %",  -- 使用標籤頁模式（類似浮動）
    -- 或使用分割視窗：
    -- windowCreationCommand = "vsplit"  -- 垂直分割
    -- windowCreationCommand = "split"   -- 水平分割

    -- ============================
    -- 搜尋引擎設置
    -- ============================
    engines = {
      ripgrep = {
        -- 顯示的選項
        showReplace = true,
        extraArgs = "",
      },
    },

    -- ============================
    -- 界面設置
    -- ============================
    -- 禁用圖標（如果沒有 Nerd Font）
    icons = {
      enabled = true,
    },

    -- 結果高亮
    resultsSeparatorLineChar = "─",
    spinnerStates = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },

    -- ============================
    -- 快捷鍵（在 grug-far 視窗中）
    -- ============================
    keymaps = {
      replace = { n = "<localleader>r" },
      qflist = { n = "<localleader>q" },
      syncLocations = { n = "<localleader>s" },
      syncLine = { n = "<localleader>l" },
      close = { n = "<localleader>c" },
      historyOpen = { n = "<localleader>t" },
      historyAdd = { n = "<localleader>a" },
      refresh = { n = "<localleader>f" },
      openLocation = { n = "<localleader>o" },
      gotoLocation = { n = "<enter>" },
      pickHistoryEntry = { n = "<enter>" },
      abort = { n = "<localleader>b" },
      help = { n = "g?" },
      toggleShowCommand = { n = "<localleader>p" },
    },

    -- ============================
    -- 預填充設置
    -- ============================
    startInInsertMode = true,

    -- ============================
    -- 歷史設置
    -- ============================
    maxHistorySize = 10,
    historyDirPath = vim.fn.stdpath("data") .. "/grug-far-history",

    -- ============================
    -- 進階設置
    -- ============================
    -- 是否在替換後自動保存
    disableBufferLineNumbers = false,
    maxWorkers = 4,
  },
  config = function(_, opts)
    require("grug-far").setup(opts)

    -- 創建用戶命令
    vim.api.nvim_create_user_command("GrugFar", function()
      require("grug-far").open()
    end, { desc = "打開 Grug-far" })

    vim.api.nvim_create_user_command("GrugFarCurrent", function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "在當前文件中搜尋替換" })
  end,
}
