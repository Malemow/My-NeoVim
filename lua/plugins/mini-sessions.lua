return {
  "echasnovski/mini.sessions",
  version = false,
  event = "VimEnter",
  keys = {
    {
      "<leader>Ss",
      function()
        local MiniSessions = require("mini.sessions")
        -- 讀取當前目錄的會話
        local session_name = vim.fn.getcwd():gsub("[/\\:]", "_"):gsub("^_", "")
        if MiniSessions.detected[session_name] then
          MiniSessions.read(session_name)
        else
          vim.notify("找不到當前目錄的會話", vim.log.levels.WARN)
        end
      end,
      desc = "恢復當前目錄會話",
    },
    {
      "<leader>Sw",
      function()
        local MiniSessions = require("mini.sessions")
        -- 保存當前目錄的會話
        local session_name = vim.fn.getcwd():gsub("[/\\:]", "_"):gsub("^_", "")
        MiniSessions.write(session_name)
        vim.notify("會話已保存: " .. session_name, vim.log.levels.INFO)
      end,
      desc = "保存當前目錄會話",
    },
    {
      "<leader>Sl",
      "<cmd>lua require('mini.sessions').select()<cr>",
      desc = "選擇並載入會話",
    },
    {
      "<leader>Sd",
      "<cmd>lua require('mini.sessions').select('delete')<cr>",
      desc = "刪除會話",
    },
    {
      "<leader>Sn",
      function()
        local session_name = vim.fn.input("會話名稱: ")
        if session_name ~= "" then
          require("mini.sessions").write(session_name)
          vim.notify("會話已保存: " .. session_name, vim.log.levels.INFO)
        end
      end,
      desc = "保存命名會話",
    },
  },
  opts = {
    -- 自動讀取會話（啟動時）
    autoread = true,

    -- 自動保存會話（退出時）
    autowrite = true,

    -- 會話保存目錄
    directory = vim.fn.stdpath("data") .. "/sessions/",

    -- 在保存會話前執行的鉤子
    hooks = {
      pre = {
        write = function()
          -- 關閉所有浮動窗口
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= "" then
              vim.api.nvim_win_close(win, false)
            end
          end
        end,
      },
      post = {
        -- 讀取會話後的操作
        read = function()
          vim.notify("會話已載入", vim.log.levels.INFO)
        end,
      },
    },
  },
  config = function(_, opts)
    local MiniSessions = require("mini.sessions")
    MiniSessions.setup(opts)

    -- 設置自動會話名稱為當前工作目錄
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = vim.api.nvim_create_augroup("MiniSessionsAutoWrite", { clear = true }),
      callback = function()
        if opts.autowrite then
          -- 使用當前目錄作為會話名稱
          local session_name = vim.fn.getcwd():gsub("[/\\:]", "_"):gsub("^_", "")
          MiniSessions.write(session_name, { force = true })
        end
      end,
    })

    -- 啟動時自動讀取當前目錄的會話
    if opts.autoread then
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("MiniSessionsAutoRead", { clear = true }),
        nested = true,
        once = true,
        callback = function()
          -- 只在沒有打開文件時才自動讀取會話
          if vim.fn.argc() == 0 then
            local session_name = vim.fn.getcwd():gsub("[/\\:]", "_"):gsub("^_", "")
            if MiniSessions.detected[session_name] then
              -- 延遲一下確保所有插件都載入完成
              vim.defer_fn(function()
                MiniSessions.read(session_name)
              end, 100)
            end
          end
        end,
      })
    end
  end,
}
