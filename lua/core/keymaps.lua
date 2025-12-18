-- 設定 <Leader> 鍵為空白鍵
vim.g.mapleader = " "

-- 取得 keymap API（方便後續設定快捷鍵）
local keymap = vim.keymap

-- =========================
-- 插入模式 (Insert mode)
-- =========================

-- 在插入模式按下 jk 會返回普通模式（比按 ESC 快許多）
keymap.set("i", "jk", "<ESC>")


-- =========================
-- 視覺模式 (Visual mode)
-- =========================

-- =========================
-- 普通模式 (Normal mode)
-- =========================

-- 水平分窗：右側開新視窗
keymap.set("n", "<leader>sv", "<C-w>v")

-- 垂直分窗：下方開新視窗
keymap.set("n", "<leader>sh", "<C-w>s")

-- 清除搜尋高亮（nohlsearch）
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- -------- buffer 操作 --------

-- 開啟新的空白 buffer
keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "新增空白 buffer" })

-- 注意：Buffer 刪除快捷鍵（<leader>q / <leader>Q）在 mini-bufremove.lua 中定義
-- 注意：<C-h/j/k/l> 保留給 vim-tmux-navigator 使用（窗口導航）

-- =========================
-- 插件 (Plugins)
-- =========================

-- nvim-tree：開關檔案樹
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
