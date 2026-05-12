-- ============================
-- 1. 初始化 lazy.nvim
-- ============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================
-- 2. 載入核心設定（在載入插件前）
-- ============================
require("core.options")
require("core.keymaps")

-- ============================
-- 3. 相容性修正
-- ============================
-- Neovim 0.10+ 移除了 ft_to_lang，Telescope 仍依賴此函數
if not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

-- ============================
-- 4. 載入所有插件
-- ============================
require("lazy").setup("plugins")
