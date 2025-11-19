-- ============================
-- claudecode.nvim: Claude Code 整合
-- ============================
-- GitHub: https://github.com/coder/claudecode.nvim
-- 功能：在 Neovim 中直接使用 Claude Code CLI 進行 AI 輔助編程

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeSend",
    "ClaudeCodeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
  },
  keys = {
    -- 主要功能
    {
      "<leader>Cc",
      "<cmd>ClaudeCode<cr>",
      desc = "切換 Claude Code",
    },
    {
      "<leader>Cf",
      "<cmd>ClaudeCodeFocus<cr>",
      desc = "聚焦 Claude Code",
    },
    {
      "<leader>Cs",
      "<cmd>ClaudeCodeSend<cr>",
      mode = "v",
      desc = "發送選取內容到 Claude",
    },
    {
      "<leader>Cm",
      "<cmd>ClaudeCodeSelectModel<cr>",
      desc = "選擇 Claude 模型",
    },
    {
      "<leader>Ca",
      function()
        -- 添加當前文件到 Claude 上下文
        vim.cmd("ClaudeCodeAdd " .. vim.fn.expand("%"))
      end,
      desc = "添加當前文件到 Claude",
    },
    {
      "<leader>CA",
      function()
        -- 添加當前文件的選取範圍到 Claude
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        vim.cmd("ClaudeCodeAdd " .. vim.fn.expand("%") .. ":" .. start_line .. ":" .. end_line)
      end,
      mode = "v",
      desc = "添加選取範圍到 Claude",
    },
    -- Diff 操作
    {
      "<leader>Cy",
      "<cmd>ClaudeCodeDiffAccept<cr>",
      desc = "接受 Claude 的修改",
    },
    {
      "<leader>Cn",
      "<cmd>ClaudeCodeDiffDeny<cr>",
      desc = "拒絕 Claude 的修改",
    },
  },
  opts = {
    -- 如果你使用本地安裝的 Claude Code，請取消註解並設置正確路徑
    -- terminal_cmd = vim.fn.expand("~/.claude/local/claude"),

    -- 終端配置
    terminal = {
      position = "bottom",  -- 終端位置: "bottom", "right", "float"
      size = 0.3,           -- 終端大小（比例）
    },
  },
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- 創建自動命令：當 Claude 建議變更時自動顯示 diff
    vim.api.nvim_create_autocmd("User", {
      pattern = "ClaudeCodeDiffReady",
      callback = function()
        vim.notify("Claude Code 建議的變更已就緒", vim.log.levels.INFO)
      end,
    })
  end,
}
