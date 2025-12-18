local opt = vim.opt  -- 取得 Neovim 的設定選項物件

opt.relativenumber = true   -- 顯示相對行號（目前行顯示絕對行號，其他行顯示相對距離）
opt.number = true           -- 顯示絕對行號

opt.tabstop = 4             -- 設定 Tab 寬度為 4 個空白
opt.shiftwidth = 4          -- 自動縮排、>>、<< 使用的縮排寬度為 4
opt.expandtab = true        -- 把 Tab 轉成空白
opt.autoindent = true       -- 新行自動沿用上一行的縮排

opt.wrap = false            -- 不自動換行（長行超出螢幕會橫向捲動）

opt.cursorline = true       -- 高亮游標所在行

opt.scrolloff = 5           -- 滾動時游標上下至少保持 5 行空間

opt.mouse:append("a")       -- 啟用滑鼠支援（所有模式可用滑鼠操作）

opt.clipboard:append("unnamedplus")  -- 啟用系統剪貼簿（可直接 copy/paste 到 OS）

opt.ignorecase = true       -- 搜尋時忽略大小寫
opt.smartcase = true        -- 搜尋字串若包含大寫，啟用大小寫敏感（比上一條更聰明）

opt.termguicolors = true    -- 啟用 24-bit 真實顏色，讓主題完整顯示

opt.signcolumn = "yes"      -- 永遠顯示 sign column，避免行號區域跳動

opt.showcmd = true          -- 在狀態列顯示部分輸入的命令（如按 g 等待下一個按鍵）

-- 加入 vim 目錄到 runtimepath，讓 Neovim 找到自訂主題
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/vim")

-- 設定主題配色
vim.cmd([[colorscheme dracula_pro_van_helsing]])

