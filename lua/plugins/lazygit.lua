-- ============================
-- lazygit.nvim: 整合 lazygit
-- ============================
-- GitHub: https://github.com/kdheepak/lazygit.nvim
-- 功能：在 Neovim 中用浮動視窗開啟 lazygit（超棒的終端 Git UI）
-- 前置需求：需要先安裝 lazygit（https://github.com/jesseduffield/lazygit）

return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- 必要的依賴
    },
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { "<leader>gg", ":LazyGit<CR>", desc = "開啟 LazyGit" },
        { "<leader>gf", ":LazyGitCurrentFile<CR>", desc = "LazyGit 當前檔案" },
    },
    config = function()
        -- ============================
        -- 快捷鍵設定
        -- ============================
        vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", {
            desc = "開啟 LazyGit",
            silent = true,
            noremap = true,
        })

        vim.keymap.set("n", "<leader>gf", ":LazyGitCurrentFile<CR>", {
            desc = "LazyGit 當前檔案",
            silent = true,
            noremap = true,
        })

        -- ============================
        -- Lazygit 視窗大小設定
        -- ============================
        -- 可以自訂浮動視窗的大小
        vim.g.lazygit_floating_window_winblend = 0 -- 透明度（0 = 不透明）
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 視窗縮放比例（0.9 = 90% 螢幕大小）
        vim.g.lazygit_floating_window_use_plenary = 0 -- 使用 plenary 來開啟視窗

        -- ============================
        -- 使用說明
        -- ============================
        -- 【前置需求】
        -- 需要先安裝 lazygit：
        --
        -- Windows (Scoop):
        --   scoop install lazygit
        --
        -- Windows (Chocolatey):
        --   choco install lazygit
        --
        -- macOS:
        --   brew install lazygit
        --
        -- Linux (Ubuntu/Debian):
        --   sudo apt install lazygit
        --
        -- 或從 GitHub 下載：
        --   https://github.com/jesseduffield/lazygit/releases
        --
        -- ============================
        -- 快捷鍵
        -- ============================
        -- <Space>gg    : 開啟 LazyGit（在當前專案）
        -- <Space>gf    : 開啟 LazyGit 並聚焦在當前檔案
        --
        -- ============================
        -- LazyGit 內的操作（簡要說明）
        -- ============================
        -- 在 LazyGit 視窗中：
        --
        -- 【基本導航】
        -- 1-5          : 切換面板（狀態、檔案、分支、提交、stash）
        -- j/k 或 ↓/↑  : 上下移動
        -- h/l 或 ←/→  : 左右切換面板
        -- q            : 退出 LazyGit
        --
        -- 【檔案操作】
        -- Space        : Stage/Unstage 檔案或變更
        -- a            : Stage/Unstage 所有檔案
        -- d            : 刪除/丟棄變更
        -- e            : 編輯檔案
        -- o            : 開啟檔案
        -- Enter        : 查看檔案的變更內容
        --
        -- 【提交操作】
        -- c            : 建立 commit
        -- A            : Amend 最後一次 commit（修改上次提交）
        -- C            : 使用 git commit (帶編輯器)
        --
        -- 【推送/拉取】
        -- p            : Push（推送到遠端）
        -- P            : Pull（從遠端拉取）
        -- f            : Fetch（獲取遠端更新）
        --
        -- 【分支操作】
        -- n            : 建立新分支
        -- Space        : Checkout 分支（切換分支）
        -- M            : Merge（合併分支）
        -- r            : Rebase（變基）
        -- d            : 刪除分支
        --
        -- 【其他】
        -- ?            : 顯示所有快捷鍵說明
        -- x            : 開啟命令選單
        -- :            : 執行自訂 git 命令
        --
        -- ============================
        -- 實用工作流程
        -- ============================
        -- 1. 編輯檔案後，按 <Space>gg 開啟 LazyGit
        -- 2. 在檔案列表按 Space stage 變更
        -- 3. 按 c 建立 commit，輸入訊息
        -- 4. 按 p push 到遠端
        -- 5. 按 q 退出 LazyGit
        --
        -- ============================
        -- 提示
        -- ============================
        -- - LazyGit 的界面非常直觀，不確定時按 ? 查看說明
        -- - 可以用滑鼠點擊（如果有啟用滑鼠支援）
        -- - 所有危險操作（刪除、force push 等）都會要求確認
        -- - 支援 Git rebase、cherry-pick、stash 等進階功能
    end,
}
