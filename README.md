# Neovim 配置說明

這是一個現代化的 Neovim 配置，專為前端開發（Vue、React、TypeScript）優化，提供類似 VSCode 的開發體驗。

## 目錄

- [特色功能](#特色功能)
- [系統需求](#系統需求)
- [安裝說明](#安裝說明)
- [核心配置](#核心配置)
- [快捷鍵總覽](#快捷鍵總覽)
- [插件列表](#插件列表)
- [主要功能詳解](#主要功能詳解)
- [LSP 語言支援](#lsp-語言支援)
- [常見問題](#常見問題)

## 特色功能

- **現代化 UI**: 使用 bufferline 提供類似 VSCode 的標籤頁體驗
- **強大的 LSP 支援**: 自動補全、跳轉定義、錯誤檢查、程式碼動作
- **智能搜尋**: Telescope 模糊搜尋檔案、文字、Git 歷史
- **Git 整合**: LazyGit 圖形化 Git 操作、Gitsigns 行內 Git 標記
- **AI 助手**: 整合 Claude Code 提供 AI 輔助編程
- **代碼片段**: 預設豐富的代碼片段，支援自訂
- **語法高亮**: TreeSitter 提供精確的語法高亮
- **快速導航**: mini.jump2d、mini.bracketed 等多種導航方式
- **調試支援**: nvim-dap 提供完整的調試功能
- **美化界面**: Noice、Lualine、mini.animate 等提升使用體驗

## 系統需求

### 必要需求

- **Neovim** >= 0.9.0
- **Git**
- **Node.js** >= 18.0（用於部分 LSP）
- **ripgrep** (用於 Telescope 文字搜尋)
- **fd** 或 **find** (用於檔案搜尋)
- 支援 Nerd Font 的終端字型（推薦 JetBrains Mono Nerd Font）

### 可選需求

- **lazygit** (用於圖形化 Git 操作)
- **Python 3** 和 **pip** (用於 Python LSP)
- **pnpm/npm/yarn** (用於前端開發)

### 安裝必要工具

**Windows (使用 Scoop):**
```bash
scoop install neovim git ripgrep fd lazygit
```

**macOS:**
```bash
brew install neovim git ripgrep fd lazygit
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install neovim git ripgrep fd-find
# lazygit 需要另外安裝，參考: https://github.com/jesseduffield/lazygit
```

## 安裝說明

### 1. 備份舊配置（如果有）

```bash
# Windows
mv $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# Linux/macOS
mv ~/.config/nvim ~/.config/nvim.bak
```

### 2. 克隆此配置

```bash
# Windows
git clone <你的倉庫地址> $env:LOCALAPPDATA\nvim

# Linux/macOS
git clone <你的倉庫地址> ~/.config/nvim
```

### 3. 啟動 Neovim

```bash
nvim
```

第一次啟動時，lazy.nvim 會自動安裝所有插件。等待安裝完成即可。

### 4. 安裝 LSP 伺服器

啟動 Neovim 後，執行：

```vim
:Mason
```

Mason 會自動安裝配置中指定的 LSP 伺服器。你也可以手動安裝：

```vim
:MasonInstall lua_ls pyright ts_ls vue_ls tailwindcss
```

## 核心配置

### 基本設定 (options.lua)

| 設定 | 說明 |
|------|------|
| `relativenumber = true` | 相對行號 |
| `number = true` | 顯示行號 |
| `tabstop = 4` | Tab 寬度為 4 |
| `expandtab = true` | Tab 轉空格 |
| `cursorline = true` | 高亮當前行 |
| `clipboard = "unnamedplus"` | 使用系統剪貼簿 |
| `ignorecase = true` | 搜尋忽略大小寫 |
| `smartcase = true` | 智能大小寫搜尋 |
| `termguicolors = true` | 啟用真彩色 |

### 配色主題

當前使用: **Dracula Pro Van Helsing**

## 快捷鍵總覽

**Leader 鍵**: `<Space>` (空格鍵)

### 基本編輯

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `jk` | Insert | 返回普通模式 (代替 ESC) |
| `<Space>nh` | Normal | 清除搜尋高亮 |
| `<Space>sv` | Normal | 垂直分割視窗 |
| `<Space>sh` | Normal | 水平分割視窗 |

### Buffer 管理

| 快捷鍵 | 功能 |
|--------|------|
| `[b` / `]b` | 上/下一個 buffer |
| `<Space>q` | 關閉當前 buffer |
| `<Space>Q` | 強制關閉 buffer |
| `<Space>bn` | 新增空白 buffer |
| `<Space>1-9` | 跳到第 1-9 個標籤 |
| `<Space>$` | 跳到最後一個標籤 |
| `<Space>bp` | 選擇 buffer (互動式) |
| `<Space>bc` | 選擇並關閉 buffer |
| `<Space>bh` | 關閉左側所有標籤 |
| `<Space>bl` | 關閉右側所有標籤 |
| `<Space>bo` | 關閉其他所有標籤 |
| `<Space>bP` | 釘選/取消釘選 buffer |
| `<Space>bm` / `<Space>bM` | 向右/左移動標籤 |

### 檔案與搜尋 (Telescope)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>e` | 開關檔案樹 (NvimTree) |
| `<Space>ff` | 搜尋檔案 |
| `<Space>fe` | 檔案瀏覽器 (當前目錄) |
| `<Space>fE` | 檔案瀏覽器 (根目錄) |
| `<Space>fh` | 搜尋檔案 (Home 目錄) |
| `<Space>fF` | 搜尋檔案 (根目錄) |
| `<Space>fr` | 搜尋最近檔案 |
| `<Space>fs` | 搜尋文字內容 (全域) |
| `<Space>fc` | 搜尋當前檔案 |
| `<Space>fb` | 搜尋 buffers |
| `<Space>fk` | 搜尋快捷鍵 |
| `<Space>f?` | 搜尋說明文件 |
| `<Space>ft` | 搜尋 TODO 註解 |

**Telescope 視窗內快捷鍵:**
- `<C-j>` / `<C-k>`: 上下移動
- `<C-h>`: 往上層目錄搜尋
- `<C-q>`: 送到 quickfix 列表
- `<C-x>`: 刪除 buffer (在 buffers 搜尋時)

### 全局搜尋與替換 (Grug-far)

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `<Space>R` | Normal | 打開全局搜尋替換 |
| `<Space>rw` | Normal | 替換當前單詞 |
| `<Space>rw` | Visual | 替換選取內容 |
| `<Space>rf` | Normal | 在當前文件替換 |

### Git 操作

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>gg` | 開啟 LazyGit |
| `<Space>gf` | LazyGit 當前檔案 |
| `<Space>gc` | 搜尋 Git commits |
| `<Space>gb` | 搜尋 Git 分支 |
| `<Space>gs` | 搜尋 Git 狀態 |

**Git Hunk 操作 (Gitsigns):**

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `<Space>hs` | Normal/Visual | Stage 變更 |
| `<Space>hu` | Normal | Unstage 變更 |
| `<Space>hr` | Normal/Visual | Reset 變更 |
| `<Space>hS` | Normal | Stage 整個檔案 |
| `[c` / `]c` | Normal | 上/下一個 Git 變更 |

### LSP 功能

| 快捷鍵 | 功能 |
|--------|------|
| `gd` | 跳到定義 |
| `gD` | 跳到聲明 |
| `gi` | 跳到實作 |
| `gr` | 查看引用 |
| `K` | 顯示懸浮文件 |
| `<C-k>` | 函式簽名提示 |
| `<Space>rn` | 重新命名符號 |
| `<Space>ca` | 程式碼動作 |
| `<Space>cd` | 顯示錯誤詳情 |
| `[d` / `]d` | 上/下一個診斷 |

### 代碼註解生成 (Neogen)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>cgf` | 生成函數註解 |
| `<Space>cgc` | 生成類別註解 |
| `<Space>cgt` | 生成類型註解 |
| `<Space>cgF` | 生成文件註解 |

### 代碼地圖與大綱

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>mm` | 開關代碼地圖 (mini.map) |
| `<Space>mf` | 聚焦代碼地圖 |
| `<Space>mr` | 刷新代碼地圖 |
| `<Space>a` | 開關符號大綱 (Aerial) |
| `[a` / `]a` | 上/下一個符號 |

### 快速跳轉與移動

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `s` | Normal | 跳轉到行首 (Jump2d) |
| `S` | Normal | 跳轉到單詞 (Jump2d) |
| `<A-h>` | Normal/Visual | 向左移動/減少縮排 |
| `<A-j>` | Normal/Visual | 向下移動 |
| `<A-k>` | Normal/Visual | 向上移動 |
| `<A-l>` | Normal/Visual | 向右移動/增加縮排 |

### mini.bracketed 導航 ([] 系統)

| 快捷鍵 | 功能 |
|--------|------|
| `[f` / `]f` | 上/下一個檔案 |
| `[w` / `]w` | 上/下一個視窗 |
| `[q` / `]q` | 上/下一個 quickfix |
| `[l` / `]l` | 上/下一個 location list |
| `[j` / `]j` | 上/下一個跳轉位置 |
| `[u` / `]u` | Undo / Redo |
| `[y` / `]y` | 上/下一個 yank |
| `[i` / `]i` | 縮排範圍頂/底部 |
| `[t` / `]t` | 上/下一個 TODO 註解 |

### 標記管理 (marks.nvim)

| 快捷鍵 | 功能 |
|--------|------|
| `m,` | 列出所有標記 |
| `m;` | 列出當前 buffer 的標記 |
| `m]` / `m[` | 跳到下/上一個標記 |
| `m:` | 預覽標記 |
| `dm-` | 刪除當前行的標記 |
| `dm=` | 刪除當前 buffer 所有標記 |

### Trouble 診斷面板

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>xx` | 診斷列表 |
| `<Space>xX` | 當前文件診斷 |
| `<Space>xs` | 符號大綱 |
| `<Space>xl` | LSP 定義/引用 |
| `<Space>xL` | Location List |
| `<Space>xQ` | Quickfix List |
| `<Space>xt` | TODO 列表 |
| `[x` / `]x` | 上/下一個問題 |

### Package 管理 (package.json)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>pt` | 切換套件資訊 |
| `<Space>ps` | 顯示套件資訊 |
| `<Space>ph` | 隱藏套件資訊 |
| `<Space>pu` | 更新套件版本 |
| `<Space>pd` | 刪除套件 |
| `<Space>pi` | 安裝新套件 |
| `<Space>pc` | 修改套件版本 |

### 調試器 (nvim-dap)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>db` | 切換中斷點 |
| `<Space>dB` | 條件中斷點 |
| `<Space>dc` | 繼續執行/開始調試 |
| `<Space>di` | 步入 |
| `<Space>do` | 步過 |
| `<Space>dO` | 步出 |
| `<Space>dr` | 切換 REPL |
| `<Space>dl` | 重新執行上次調試 |
| `<Space>dt` | 終止調試 |
| `<Space>du` | 切換調試 UI |
| `<Space>de` | 評估表達式 |

### 終端管理 (toggleterm)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>tt` | 浮動終端 |
| `<Space>th` | 水平終端 |
| `<Space>tv` | 垂直終端 |
| `<Space>tg` | Lazygit 終端 |
| `<Space>tn` | Node 終端 |
| `<Space>tp` | Python 終端 |
| `<C-\>` | 切換終端 |

### 會話管理 (mini.sessions)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>Ss` | 恢復當前目錄會話 |
| `<Space>Sw` | 保存當前目錄會話 |
| `<Space>Sl` | 選擇並載入會話 |
| `<Space>Sd` | 刪除會話 |
| `<Space>Sn` | 保存命名會話 |

### AI 助手 (Claude Code)

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `<Space>Cc` | Normal | 切換 Claude Code |
| `<Space>Cf` | Normal | 聚焦 Claude Code |
| `<Space>Cm` | Normal | 選擇 Claude 模型 |
| `<Space>Cs` | Visual | 發送選取內容到 Claude |
| `<Space>Ca` | Normal | 添加當前文件到 Claude |
| `<Space>CA` | Visual | 添加選取範圍到 Claude |
| `<Space>Cy` | Normal | 接受 Claude 的修改 |
| `<Space>Cn` | Normal | 拒絕 Claude 的修改 |

### 代碼折疊 (nvim-ufo)

| 快捷鍵 | 功能 |
|--------|------|
| `zR` | 打開所有折疊 |
| `zM` | 關閉所有折疊 |
| `zr` | 減少折疊層級 |
| `zm` | 增加折疊層級 |
| `zp` | 預覽折疊 |

### Noice 通知管理

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>nh` | 顯示 Noice 歷史 |
| `<Space>nd` | 關閉所有通知 |
| `<Space>ne` | 顯示錯誤 |

### 自動補全 (nvim-cmp)

**在補全選單中:**

| 快捷鍵 | 功能 |
|--------|------|
| `<C-j>` / `<C-k>` | 上下選擇 |
| `<Tab>` | 選下一個/展開代碼片段 |
| `<S-Tab>` | 選上一個 |
| `<CR>` | 確認選擇 |
| `<C-Space>` | 手動觸發補全 |
| `<C-e>` | 關閉補全選單 |
| `<C-b>` / `<C-f>` | 捲動文件視窗 |

### TreeSitter 智能選取

| 快捷鍵 | 功能 |
|--------|------|
| `<C-Space>` | 開始/擴大選取 |
| `<BS>` | 縮小選取 |

## 插件列表

### 核心插件

| 插件 | 功能 |
|------|------|
| **lazy.nvim** | 插件管理器 |
| **plenary.nvim** | Lua 函式庫（多個插件依賴） |
| **nvim-web-devicons** | 檔案圖示 |
| **nui.nvim** | UI 組件庫 |

### 編輯增強

| 插件 | 功能 |
|------|------|
| **nvim-treesitter** | 語法高亮與程式碼理解 |
| **nvim-treesitter-textobjects** | 文字物件（選取函式、類別等） |
| **nvim-ts-autotag** | HTML/JSX 自動關閉標籤 |
| **mini.comment** | 快速註解 |
| **mini.pairs** | 自動配對括號 |
| **mini.surround** | 快速修改包圍符號 |
| **mini.ai** | 增強文字物件 |
| **mini.move** | 移動行/區塊 |

### LSP 與補全

| 插件 | 功能 |
|------|------|
| **mason.nvim** | LSP/DAP/Linter 管理器 |
| **mason-lspconfig.nvim** | Mason 與 LSP 橋接 |
| **nvim-lspconfig** | LSP 配置 |
| **nvim-cmp** | 自動補全引擎 |
| **cmp-nvim-lsp** | LSP 補全源 |
| **cmp-buffer** | Buffer 補全源 |
| **cmp-path** | 路徑補全源 |
| **LuaSnip** | 代碼片段引擎 |
| **cmp_luasnip** | LuaSnip 補全源 |
| **friendly-snippets** | 預設代碼片段集合 |
| **lspkind.nvim** | 補全選單圖示 |

### 搜尋與導航

| 插件 | 功能 |
|------|------|
| **telescope.nvim** | 模糊搜尋工具 |
| **telescope-file-browser.nvim** | 檔案瀏覽器擴展 |
| **nvim-tree.lua** | 檔案樹 |
| **aerial.nvim** | 符號大綱 |
| **mini.jump2d** | 快速跳轉 |
| **mini.bracketed** | [] 系統導航 |
| **mini.indentscope** | 縮排範圍可視化 |
| **marks.nvim** | 標記管理 |
| **grug-far.nvim** | 全局搜尋與替換 |

### Git 整合

| 插件 | 功能 |
|------|------|
| **gitsigns.nvim** | Git 變更標記 |
| **lazygit.nvim** | LazyGit 整合 |

### UI 與視覺

| 插件 | 功能 |
|------|------|
| **bufferline.nvim** | 標籤頁管理 |
| **lualine.nvim** | 狀態列 |
| **statuscol.nvim** | 增強行號欄 |
| **noice.nvim** | 命令列與通知 UI |
| **nvim-notify** | 通知系統 |
| **dressing.nvim** | 美化輸入/選擇 UI |
| **mini.starter** | 啟動畫面 |
| **mini.animate** | 動畫效果 |
| **mini.cursorword** | 高亮當前單詞 |
| **mini.hipatterns** | 高亮特殊模式（顏色碼等） |
| **mini.map** | 代碼地圖 |

### 調試與測試

| 插件 | 功能 |
|------|------|
| **nvim-dap** | 調試適配器協定 |
| **nvim-dap-ui** | 調試 UI |
| **nvim-dap-virtual-text** | 調試虛擬文字 |
| **mason-nvim-dap.nvim** | Mason DAP 橋接 |

### 實用工具

| 插件 | 功能 |
|------|------|
| **toggleterm.nvim** | 終端管理 |
| **which-key.nvim** | 快捷鍵提示 |
| **trouble.nvim** | 診斷列表 |
| **todo-comments.nvim** | TODO 註解高亮 |
| **package-info.nvim** | package.json 管理 |
| **neogen** | 文檔註解生成 |
| **nvim-ufo** | 代碼折疊 |
| **promise-async** | 非同步操作 |
| **mini.sessions** | 會話管理 |
| **mini.bufremove** | 安全關閉 buffer |

### AI 助手

| 插件 | 功能 |
|------|------|
| **claudecode.nvim** | Claude Code 整合 |
| **snacks.nvim** | 實用小工具集合 |

### 其他

| 插件 | 功能 |
|------|------|
| **vim-tmux-navigator** | Tmux 視窗導航 |

## 主要功能詳解

### Telescope 模糊搜尋

Telescope 是最常用的功能之一，提供快速搜尋能力：

**檔案搜尋工作流程:**
1. 按 `<Space>ff` 搜尋檔案
2. 輸入檔名（支援模糊匹配）
3. `<C-j>`/`<C-k>` 上下選擇
4. `Enter` 開啟檔案

**文字搜尋工作流程:**
1. 按 `<Space>fs` 搜尋文字
2. 輸入關鍵字
3. 查看所有匹配結果
4. `<C-q>` 可送到 quickfix 批次處理

**特殊功能:**
- 在搜尋視窗按 `<C-h>` 可往上層目錄搜尋
- 支援正則表達式
- 可用空格分隔多個搜尋詞

### LSP 程式語言支援

配置自動安裝以下 LSP 伺服器：

- **lua_ls**: Lua
- **pyright**: Python
- **ts_ls**: TypeScript/JavaScript
- **vue_ls**: Vue 3
- **html**: HTML
- **cssls**: CSS
- **tailwindcss**: Tailwind CSS
- **emmet_ls**: Emmet
- **jsonls**: JSON
- **yamlls**: YAML

**常用 LSP 操作:**

1. **跳轉到定義**: 將游標移到變數/函式上，按 `gd`
2. **查看文件**: 按 `K` 查看懸浮文件
3. **重新命名**: 按 `<Space>rn` 重新命名（自動更新所有引用）
4. **查看引用**: 按 `gr` 查看誰在使用這個函式
5. **程式碼動作**: 按 `<Space>ca` 查看可用的快速修復

**診斷符號:**
-  : 錯誤
-  : 警告
-  : 提示
-  : 資訊

### 自動補全系統

nvim-cmp 提供智能補全：

**補全源優先順序:**
1. **LSP**: 函式、變數、類別等
2. **Snippet**: 代碼片段
3. **Buffer**: 當前檔案中的文字
4. **Path**: 檔案路徑

**使用技巧:**
- 開始打字會自動彈出補全選單
- `<Tab>` 選擇並確認
- 代碼片段中按 `<Tab>` 跳到下一個佔位符
- 路徑補全: 輸入 `./` 或 `/` 觸發

### Git 工作流程

**使用 LazyGit (推薦):**
1. 編輯檔案後按 `<Space>gg`
2. 在檔案列表按 `Space` stage 變更
3. 按 `c` 建立 commit
4. 按 `p` push 到遠端
5. 按 `q` 退出

**使用 Gitsigns:**
- `<Space>hs`: Stage 當前變更
- `[c` / `]c`: 在變更間跳轉
- `<Space>hr`: 重置變更

### Buffer 管理

**快速跳轉:**
- `<Space>1-9`: 直接跳到第 1-9 個標籤
- `[b` / `]b`: 循環切換

**批次操作:**
- `<Space>bh` / `<Space>bl`: 關閉左/右側所有標籤
- `<Space>bo`: 只保留當前標籤

**進階功能:**
- `<Space>bp`: 互動式選擇 buffer (輸入字母跳轉)
- `<Space>bP`: 釘選重要的 buffer

### 代碼導航

**多種導航方式:**

1. **LSP 跳轉**: `gd`、`gi`、`gr`
2. **快速跳轉**: `s` (行首)、`S` (單詞)
3. **[] 導航**: `[d`、`]d` (診斷)、`[t`、`]t` (TODO)
4. **符號大綱**: `<Space>a` 開啟 Aerial

### AI 助手 (Claude Code)

整合 Claude Code 提供 AI 輔助：

**基本使用:**
1. `<Space>Cc`: 切換 Claude Code 視窗
2. `<Space>Ca`: 添加當前文件到 Claude
3. `<Space>Cs`: (Visual mode) 發送選取內容
4. `<Space>Cy` / `<Space>Cn`: 接受/拒絕修改

### 調試 (nvim-dap)

**調試工作流程:**
1. `<Space>db`: 設置中斷點
2. `<Space>dc`: 開始調試
3. `<Space>di` / `<Space>do`: 步入/步過
4. `<Space>du`: 開啟調試 UI
5. `<Space>dt`: 終止調試

## LSP 語言支援

### 已配置的語言

| 語言 | LSP 伺服器 | 功能 |
|------|-----------|------|
| **Lua** | lua_ls | 補全、診斷、格式化 |
| **Python** | pyright | 補全、類型檢查、診斷 |
| **JavaScript** | ts_ls | 補全、診斷、重構 |
| **TypeScript** | ts_ls | 補全、類型檢查、診斷 |
| **Vue 3** | vue_ls | 補全、診斷、Volar 支援 |
| **HTML** | html | 補全、驗證 |
| **CSS** | cssls | 補全、驗證 |
| **Tailwind CSS** | tailwindcss | 類別補全、懸浮預覽 |
| **JSON** | jsonls | 補全、驗證 |
| **YAML** | yamlls | 補全、驗證 |
| **Emmet** | emmet_ls | HTML/CSS 快速編寫 |

### TreeSitter 語法支援

已安裝的 parser:
- Web 前端: html, css, scss, javascript, typescript, tsx, vue
- 後端: python, lua, bash
- 數據格式: json, yaml, markdown
- 其他: vim, vimdoc, gitignore, dockerfile

## 常見問題

### Q: 如何安裝新的 LSP 伺服器？

A: 執行 `:Mason`，在 UI 中搜尋並安裝，或使用 `:MasonInstall <server_name>`

### Q: 補全不工作怎麼辦？

A:
1. 檢查 LSP 是否啟動: `:LspInfo`
2. 確認 Mason 已安裝對應的 LSP
3. 重啟 Neovim

### Q: 如何更新所有插件？

A:
```vim
:Lazy sync
```

### Q: TreeSitter 語法高亮異常？

A:
```vim
:TSUpdate
:checkhealth nvim-treesitter
```

### Q: 如何自訂快捷鍵？

A: 編輯 `lua/core/keymaps.lua` 或各個插件的配置檔案

### Q: 如何更改主題？

A: 編輯 `lua/core/options.lua`，修改 `colorscheme` 設定

### Q: LazyGit 提示找不到命令？

A: 需要單獨安裝 lazygit，參考[安裝說明](#系統需求)

### Q: 如何禁用某個插件？

A: 在對應的插件配置檔案中添加 `enabled = false`，或直接刪除該檔案

### Q: 如何查看所有可用的快捷鍵？

A: 按 `<Space>` 等待 500ms，which-key 會顯示所有可用快捷鍵

### Q: 如何在多個專案間切換？

A: 使用會話管理:
- `<Space>Sw`: 保存當前專案會話
- `<Space>Sl`: 載入其他專案會話

## 快速開始指南

### 新手推薦工作流程

**1. 開啟專案:**
```bash
cd your-project
nvim
```

**2. 基本操作:**
- `<Space>e`: 開啟檔案樹，瀏覽專案結構
- `<Space>ff`: 快速搜尋並開啟檔案
- `jk`: 隨時返回普通模式

**3. 編輯代碼:**
- 自動補全會在你打字時出現
- `<Tab>` 選擇補全項目
- `K` 查看函式文件
- `gd` 跳到定義

**4. Git 操作:**
- `<Space>gg`: 開啟 LazyGit
- 按 `?` 查看 LazyGit 的快捷鍵說明

**5. 查找問題:**
- `[d` / `]d`: 在錯誤間跳轉
- `<Space>xx`: 查看所有診斷

## 進階技巧

### 1. 使用會話快速切換專案

```vim
" 在專案 A 中
:lua MiniSessions.write('project-a')

" 稍後切換回來
<Space>Sl  " 選擇 project-a
```

### 2. 使用 TODO 註解追蹤任務

```javascript
// TODO: 需要優化這個函式
// FIXME: 修復這個 bug
// NOTE: 這裡有重要說明
// HACK: 臨時解決方案
```

然後用 `<Space>ft` 搜尋所有 TODO

### 3. 使用代碼片段加速編寫

輸入 `for` + `<Tab>` 自動展開 for 迴圈模板

### 4. 多游標編輯

1. 選取單詞
2. 按 `<C-space>` 擴大選取
3. 使用 visual block mode (`<C-v>`) 多行編輯

### 5. 使用 mini.jump2d 快速跳轉

按 `s`，輸入行首字元，再輸入顯示的標籤字母

## 自訂指南

### 添加新插件

在 `lua/plugins/` 目錄下建立新的 `.lua` 檔案:

```lua
-- lua/plugins/example.lua
return {
    "author/plugin-name",
    config = function()
        -- 配置代碼
    end,
}
```

### 修改快捷鍵

編輯 `lua/core/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", ":YourCommand<CR>", { desc = "說明" })
```

### 添加 LSP 伺服器

編輯 `lua/plugins/lsp.lua`，在 `ensure_installed` 中添加:

```lua
ensure_installed = {
    "lua_ls",
    -- ... 其他
    "rust_analyzer",  -- 添加新的 LSP
}
```

## 檔案結構

```
nvim/
├── init.lua                 # 入口檔案
├── lazy-lock.json          # 插件版本鎖定
├── lua/
│   ├── core/
│   │   ├── options.lua     # 核心設定
│   │   └── keymaps.lua     # 基本快捷鍵
│   └── plugins/            # 插件配置
│       ├── aerial.lua
│       ├── bufferline.lua
│       ├── claudecode.lua
│       ├── dressing.lua
│       ├── gitsigns.lua
│       ├── grug-far.lua
│       ├── lazygit.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── marks.lua
│       ├── mini-*.lua      # mini.nvim 系列插件
│       ├── neogen.lua
│       ├── noice.lua
│       ├── nvim-cmp.lua
│       ├── nvim-dap.lua
│       ├── nvim-tree.lua
│       ├── nvim-ts-autotag.lua
│       ├── nvim-ufo.lua
│       ├── package-info.lua
│       ├── snacks.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── toggleterm.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       ├── vim-tmux-navigator.lua
│       └── which-key.lua
└── vim/
    └── colors/             # 自訂主題
```

## 更新日誌

查看 Git 提交歷史以了解最新變更。

## 貢獻

歡迎提交 Issue 和 Pull Request！

## 授權

MIT License

## 鳴謝

感謝所有插件作者的辛勤付出！

---

**提示:** 按 `<Space>` 並等待 500ms，which-key 會顯示所有可用的快捷鍵提示。這是學習快捷鍵的最佳方式！
