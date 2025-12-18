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
    "ClaudeCodeTreeAdd"
  },
  keys = {
    -- 主要功能
    {
      "<leader>ac",
      "<cmd>ClaudeCode<cr>",
      desc = "切換 Claude Code",
    },
    {
      "<leader>af",
      "<cmd>ClaudeCodeFocus<cr>",
      desc = "聚焦 Claude Code",
    },
    {
      "<leader>aC",
      "<cmd>ClaudeCode --continue<cr>",
      desc = "繼續 Claude Continue",
    },
    {
      "<leader>am",
      "<cmd>ClaudeCodeSelectModel<cr>",
      desc = "選擇 Claude Continue Model",
    },
    {
      "<leader>ab",
      "<cmd>ClaudeCodeAdd %<cr>",
      desc = "發送 Current Buffer 內容到 Claude",
    },
    {
      "<leader>as",
      "<cmd>ClaudeCodeSend<cr>",
      mode = "v",
      desc = "發送選取內容到 Claude",
    },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "添加當前文件到 Claude",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" }
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
