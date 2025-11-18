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

-- 切換到下一個 buffer（使用 ]b 向後跳）
keymap.set("n", "]b", ":bnext<CR>")

-- 切換到上一個 buffer（使用 [b 向前跳）
keymap.set("n", "[b", ":bprevious<CR>")

-- 開啟新的空白 buffer
keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "新增空白 buffer" })

-- 關閉當前 buffer（更直觀的快捷鍵）
keymap.set("n", "<leader>q", ":bd<CR>", { desc = "關閉當前 buffer" })

-- 強制關閉當前 buffer
keymap.set("n", "<leader>Q", ":bd!<CR>", { desc = "強制關閉 buffer（不儲存）" })

-- 注意：<C-h/j/k/l> 保留給 vim-tmux-navigator 使用（窗口導航）

-- =========================
-- 插件 (Plugins)
-- =========================

-- nvim-tree：開關檔案樹
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
