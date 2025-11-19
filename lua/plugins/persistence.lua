return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>Ss",
      function()
        require("persistence").load()
      end,
      desc = "恢復會話",
    },
    {
      "<leader>Sl",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "恢復上次會話",
    },
    {
      "<leader>Sd",
      function()
        require("persistence").stop()
      end,
      desc = "停止會話記錄",
    },
  },
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
    pre_save = nil, -- a function to call before saving the session
    save_empty = false, -- don't save if there are no open file buffers
  },
}
