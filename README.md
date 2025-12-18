# Neovim 現代化配置

> 專為前端開發（Vue、React、TypeScript）優化的 Neovim 配置，提供類似 VSCode 的開發體驗

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://lua.org)

## 📑 目錄

- [✨ 特色功能](#-特色功能)
- [🏗️ 架構設計](#️-架構設計)
- [📦 系統需求](#-系統需求)
- [🚀 安裝說明](#-安裝說明)
- [🔧 核心配置](#-核心配置)
- [📦 插件系統](#-插件系統)
- [⌨️ 快捷鍵總覽](#️-快捷鍵總覽)
- [📚 主要功能詳解](#-主要功能詳解)
- [🔮 未來功能規劃](#-未來功能規劃)
- [❓ 常見問題](#-常見問題)
- [🤝 貢獻](#-貢獻)

---

## ✨ 特色功能

### 核心特性

- 🎨 **現代化 UI**: 使用 bufferline 提供類似 VSCode 的標籤頁體驗
- 🧠 **強大的 LSP 支援**: 自動補全、跳轉定義、錯誤檢查、程式碼動作
- 🔍 **智能搜尋**: Telescope 模糊搜尋檔案、文字、Git 歷史
- 🌿 **Git 整合**: LazyGit 圖形化 Git 操作、Gitsigns 行內 Git 標記
- 🤖 **AI 助手**: 整合 Claude Code 提供 AI 輔助編程
- 📝 **代碼片段**: 預設豐富的代碼片段，支援自訂
- 🎯 **精確語法高亮**: TreeSitter 提供精確的語法解析
- ⚡ **快速導航**: mini.jump2d、mini.bracketed 等多種導航方式
- 🐛 **調試支援**: nvim-dap 提供完整的調試功能
- 🎭 **美化界面**: Noice、Lualine、mini.animate 等提升使用體驗

### 設計理念

1. **模塊化**: 每個插件獨立配置，易於維護和擴展
2. **輕量級**: 優先選擇 mini.nvim 系列插件，保持配置簡潔
3. **漸進式**: 支援 lazy loading，啟動速度快
4. **一致性**: 快捷鍵遵循統一規範，易於記憶
5. **可讀性**: 詳細註釋，方便理解和自訂

---

## 🏗️ 架構設計

### 目錄結構

```
nvim/
├── init.lua                 # 入口檔案：初始化 lazy.nvim 和載入模組
├── lazy-lock.json          # 插件版本鎖定檔案
├── lua/
│   ├── core/               # 核心配置（在插件載入前執行）
│   │   ├── options.lua    # Neovim 基本設定（行號、縮排、主題等）
│   │   └── keymaps.lua    # 核心快捷鍵（不依賴插件的基本操作）
│   └── plugins/           # 插件配置（每個插件一個獨立檔案）
│       ├── lsp.lua        # LSP 配置（Mason + nvim-lspconfig）
│       ├── nvim-cmp.lua   # 自動補全
│       ├── telescope.lua  # 模糊搜尋
│       ├── bufferline.lua # 標籤頁管理
│       ├── which-key.lua  # 快捷鍵提示
│       └── ...            # 其他 40+ 插件
└── vim/
    └── colors/            # 自訂配色主題
        └── dracula_pro_van_helsing.vim
```

### 初始化流程

```
啟動 Neovim
    ↓
init.lua
    ├─→ 初始化 lazy.nvim（插件管理器）
    ├─→ 載入 core.options（基本設定）
    ├─→ 載入 core.keymaps（核心快捷鍵）
    └─→ lazy.nvim 自動載入 plugins/ 下的所有插件
           ├─→ 根據 event、cmd、keys 等條件 lazy loading
           └─→ 插件載入後執行各自的 config() 函數
```

### 配置哲學

#### 1. 核心 vs 插件快捷鍵分離

- **core/keymaps.lua**: 不依賴插件的基本操作
  - 插入模式快捷鍵（如 `jk` 返回普通模式）
  - 視窗分割、buffer 導航
  - 基本編輯操作

- **plugins/*.lua**: 每個插件管理自己的快捷鍵
  - 使用 `keys` 參數實現 lazy loading
  - 快捷鍵與插件功能綁定，易於管理

#### 2. Lazy Loading 策略

- **event**: 根據 Vim 事件觸發（如 `BufReadPost`、`VeryLazy`）
- **cmd**: 執行命令時載入（如 `:Mason`、`:Telescope`）
- **keys**: 按下快捷鍵時載入（如 `<leader>ff`）
- **ft**: 開啟特定檔案類型時載入（如 `.vue`、`.tsx`）

#### 3. mini.nvim 優先

優先使用 mini.nvim 系列插件：
- 輕量級、高品質
- 功能聚焦、不臃腫
- API 設計一致
- 易於整合

---

## 📦 系統需求

### 必要工具

| 工具 | 版本 | 用途 |
|------|------|------|
| **Neovim** | >= 0.9.0 | 編輯器本體 |
| **Git** | 最新版 | 版本控制、插件管理 |
| **Node.js** | >= 18.0 | 部分 LSP、格式化工具 |
| **ripgrep** | 最新版 | Telescope 文字搜尋 |
| **fd** | 最新版 | Telescope 檔案搜尋 |
| **Nerd Font** | 任意 | 圖示顯示（推薦 JetBrains Mono）|

### 可選工具

| 工具 | 用途 |
|------|------|
| **lazygit** | 圖形化 Git 操作 |
| **Python 3** | Python LSP |
| **pnpm/npm** | 前端套件管理 |

### 安裝指令

**Windows (Scoop):**
```powershell
scoop install neovim git ripgrep fd lazygit nodejs
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```

**macOS (Homebrew):**
```bash
brew install neovim git ripgrep fd lazygit node
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install neovim git ripgrep fd-find nodejs npm
# lazygit 需另外安裝: https://github.com/jesseduffield/lazygit
```

---

## 🚀 安裝說明

### 快速安裝

```bash
# 1. 備份舊配置
mv ~/.config/nvim ~/.config/nvim.bak  # Linux/macOS
mv $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak  # Windows

# 2. 克隆此配置
git clone <你的倉庫地址> ~/.config/nvim  # Linux/macOS
git clone <你的倉庫地址> $env:LOCALAPPDATA\nvim  # Windows

# 3. 啟動 Neovim
nvim
```

### 首次啟動

1. **自動安裝插件**: lazy.nvim 會自動下載並安裝所有插件
2. **等待安裝完成**: 可以按 `q` 關閉安裝視窗
3. **安裝 LSP**: 執行 `:Mason` 查看 LSP 安裝狀態
4. **重啟 Neovim**: 確保所有配置生效

### 驗證安裝

```vim
:checkhealth               " 檢查整體健康狀態
:checkhealth nvim-treesitter  " 檢查 TreeSitter
:checkhealth lsp           " 檢查 LSP
:Lazy                      " 查看插件狀態
:Mason                     " 查看 LSP/DAP/Linter 狀態
```

---

## 🔧 核心配置

### 基本設定 (core/options.lua)

```lua
-- 行號與捲動
relativenumber = true      -- 相對行號
number = true              -- 顯示行號
scrolloff = 5              -- 游標上下保持 5 行空間

-- 縮排與 Tab
tabstop = 4                -- Tab 寬度為 4
shiftwidth = 4             -- 自動縮排寬度為 4
expandtab = true           -- Tab 轉空格
autoindent = true          -- 自動縮排

-- 搜尋
ignorecase = true          -- 搜尋忽略大小寫
smartcase = true           -- 包含大寫時區分大小寫

-- UI
cursorline = true          -- 高亮當前行
termguicolors = true       -- 啟用真彩色
signcolumn = "yes"         -- 永久顯示符號欄

-- 剪貼簿
clipboard = "unnamedplus"  -- 使用系統剪貼簿
```

### 配色主題

當前使用: **Dracula Pro Van Helsing**

修改主題：編輯 `lua/core/options.lua` 第 32 行

---

## 📦 插件系統

### 插件管理器

使用 **lazy.nvim** - 現代化的 Neovim 插件管理器

特點：
- ⚡ 快速啟動（lazy loading）
- 📦 自動安裝和更新
- 🔒 版本鎖定（lazy-lock.json）
- 🎨 美觀的 UI

### 插件分類

#### 🎨 UI 與視覺 (8 個)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **bufferline.nvim** | 標籤頁管理 | `<Space>1-9`, `[b`/`]b` |
| **lualine.nvim** | 狀態列 | - |
| **noice.nvim** | 美化命令列和通知 | `<Space>nH/nd/ne` |
| **nvim-notify** | 通知系統 | - |
| **dressing.nvim** | 美化輸入/選擇 UI | - |
| **mini.starter** | 啟動畫面 | - |
| **mini.animate** | 動畫效果 | - |
| **mini.cursorword** | 高亮當前單詞 | - |

#### 🧠 LSP 與補全 (7 個)

| 插件 | 功能 | 命令/快捷鍵 |
|------|------|------------|
| **mason.nvim** | LSP 管理器 | `:Mason` |
| **nvim-lspconfig** | LSP 配置 | `gd`, `gr`, `K`, `<Space>ca` |
| **nvim-cmp** | 自動補全引擎 | `<Tab>`, `<CR>` |
| **LuaSnip** | 代碼片段引擎 | `<Tab>` 跳轉 |
| **lspkind.nvim** | 補全圖示 | - |
| **friendly-snippets** | 預設代碼片段 | - |
| **nvim-treesitter** | 語法解析與高亮 | - |

#### 🔍 搜尋與導航 (9 個)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **telescope.nvim** | 模糊搜尋 | `<Space>ff/fs/fr/fb` |
| **nvim-tree.lua** | 檔案樹 | `<Space>e` |
| **aerial.nvim** | 符號大綱 | `<Space>a` |
| **mini.jump2d** | 快速跳轉 | `s`, `S` |
| **mini.bracketed** | [] 系統導航 | `[b`, `]d`, `[t` 等 |
| **mini.indentscope** | 縮排範圍可視化 | - |
| **marks.nvim** | 標記管理 | `m,`, `m;`, `m[`, `m]` |
| **grug-far.nvim** | 全局搜尋替換 | `<Space>R/rw/rf` |
| **mini.map** | 代碼地圖 | `<Space>mm/mf/mr` |

#### 🌿 Git 整合 (2 個)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **gitsigns.nvim** | Git 變更標記 | `<Space>hs/hu/hr`, `[c`/`]c` |
| **lazygit.nvim** | LazyGit 整合 | `<Space>gg/gf` |

#### ✏️ 編輯增強 (8 個 - mini 系列)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **mini.comment** | 快速註解 | `gc`, `gcc` |
| **mini.pairs** | 自動配對括號 | - |
| **mini.surround** | 快速修改包圍符號 | `sa`, `sd`, `sr` |
| **mini.ai** | 增強文字物件 | `a`, `i` 增強 |
| **mini.move** | 移動行/區塊 | `<A-hjkl>` |
| **mini.bufremove** | 安全關閉 buffer | `<Space>q/Q` |
| **mini.sessions** | 會話管理 | `<Space>Ss/Sw/Sl` |
| **nvim-ts-autotag** | HTML/JSX 自動關閉標籤 | - |

#### 🐛 調試與測試 (4 個)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **nvim-dap** | 調試適配器協定 | `<Space>db/dc/di/do` |
| **nvim-dap-ui** | 調試 UI | `<Space>du` |
| **nvim-dap-virtual-text** | 調試虛擬文字 | - |
| **trouble.nvim** | 診斷列表 | `<Space>xx/xX/xs` |

#### 🛠️ 實用工具 (7 個)

| 插件 | 功能 | 快捷鍵/命令 |
|------|------|------------|
| **toggleterm.nvim** | 終端管理 | `<Space>tt/th/tv/tg` |
| **which-key.nvim** | 快捷鍵提示 | 按 `<Space>` 等待 |
| **todo-comments.nvim** | TODO 註解高亮 | `]t`/`[t`, `<Space>ft` |
| **package-info.nvim** | package.json 管理 | `<Space>pt/ps/pu` |
| **neogen** | 文檔註解生成 | `<Space>cgf/cgc` |
| **nvim-ufo** | 代碼折疊 | `zR/zM/zp` |
| **mini.hipatterns** | 高亮特殊模式（如顏色碼）| - |

#### 🤖 AI 助手 (2 個)

| 插件 | 功能 | 快捷鍵 |
|------|------|--------|
| **claudecode.nvim** | Claude Code 整合 | `<Space>Cc/Cf/Ca/Cy` |
| **snacks.nvim** | 實用小工具集合 | - |

---

## ⌨️ 快捷鍵總覽

### Leader 鍵: `<Space>` (空格鍵)

### 核心快捷鍵（不依賴插件）

| 快捷鍵 | 模式 | 功能 |
|--------|------|------|
| `jk` | Insert | 返回普通模式（代替 ESC）|
| `<Space>sv` | Normal | 垂直分割視窗 |
| `<Space>sh` | Normal | 水平分割視窗 |
| `<Space>nh` | Normal | 清除搜尋高亮 |
| `<Space>e` | Normal | 開關檔案樹 |
| `<Space>bn` | Normal | 新增空白 buffer |
| `[b` / `]b` | Normal | 上/下一個 buffer |

### Buffer 管理

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>q` | **關閉當前 buffer** |
| `<Space>Q` | **強制關閉 buffer（不儲存）** |
| `<Space>1-9` | 跳到第 1-9 個標籤 |
| `<Space>$` | 跳到最後一個標籤 |
| `<Space>bp` | 選擇 buffer（互動式）|
| `<Space>bc` | 選擇並關閉 buffer |
| `<Space>bh/bl` | 關閉左/右側所有標籤 |
| `<Space>bo` | 關閉其他所有標籤 |
| `<Space>bP` | 釘選/取消釘選 buffer |

### 搜尋功能 (Telescope)

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>ff` | 搜尋檔案 |
| `<Space>fr` | 搜尋最近檔案 |
| `<Space>fs` | 搜尋文字內容（全域）|
| `<Space>fb` | 搜尋 buffers |
| `<Space>fk` | 搜尋快捷鍵 |
| `<Space>ft` | 搜尋 TODO 註解 |
| `<Space>R` | 全局搜尋替換（Grug-far）|

### LSP 功能

| 快捷鍵 | 功能 |
|--------|------|
| `gd` | 跳到定義 |
| `gr` | 查看引用 |
| `gi` | 跳到實作 |
| `K` | 顯示懸浮文件 |
| `<Space>ca` | 程式碼動作 |
| `<Space>rn` | 重新命名符號 |
| `<Space>cf` | 格式化程式碼 |
| `<Space>d` | 顯示錯誤詳情 |
| `[d` / `]d` | 上/下一個錯誤 |

### Git 操作

| 快捷鍵 | 功能 |
|--------|------|
| `<Space>gg` | 開啟 LazyGit |
| `<Space>hs` | Stage 變更 |
| `<Space>hu` | Unstage 變更 |
| `<Space>hr` | Reset 變更 |
| `[c` / `]c` | 上/下一個 Git 變更 |

### 完整快捷鍵

按 `<Space>` 並等待 500ms，**which-key** 會自動顯示所有可用快捷鍵！

---

## 📚 主要功能詳解

### 1. LSP 語言支援

#### 自動安裝的語言伺服器

| 語言 | LSP Server | 功能 |
|------|-----------|------|
| Lua | lua_ls | 補全、診斷、Neovim API 支援 |
| Python | pyright | 類型檢查、補全 |
| JavaScript/TypeScript | ts_ls | 補全、重構、類型檢查 |
| Vue | vue_ls | Vue 3、Volar 支援 |
| HTML | html | 補全、驗證 |
| CSS | cssls | 補全、驗證 |
| Tailwind CSS | tailwindcss | 類別補全、顏色預覽 |
| JSON | jsonls | 補全、驗證 |
| YAML | yamlls | 補全、驗證 |
| Emmet | emmet_ls | HTML/CSS 快速編寫 |

#### 添加新語言支援

編輯 `lua/plugins/lsp.lua`:

```lua
ensure_installed = {
    -- 現有的...
    "rust_analyzer",  -- 添加 Rust 支援
    "gopls",          -- 添加 Go 支援
}
```

### 2. 自動補全系統

**補全源優先順序**:
1. LSP（函式、變數、類別）
2. Snippet（代碼片段）
3. Buffer（當前檔案文字）
4. Path（檔案路徑）

**快捷鍵**:
- `<Tab>` - 選擇下一個
- `<S-Tab>` - 選擇上一個
- `<CR>` - 確認選擇
- `<C-Space>` - 手動觸發補全
- `<C-e>` - 關閉補全選單

### 3. Telescope 模糊搜尋

**工作流程**:
1. `<Space>ff` - 搜尋檔案
2. 輸入關鍵字（支援模糊匹配）
3. `<C-j>`/`<C-k>` - 上下移動
4. `<CR>` - 開啟檔案
5. `<C-q>` - 送到 quickfix 列表

**進階技巧**:
- 空格分隔多個搜尋詞
- `!word` 排除包含 word 的結果
- `'word` 精確匹配

### 4. Git 工作流程

#### 使用 LazyGit（推薦）

1. `<Space>gg` - 開啟 LazyGit
2. `Space` - Stage/Unstage 檔案
3. `c` - Commit
4. `p` - Push
5. `q` - 退出

#### 使用 Gitsigns

- `<Space>hs` - Stage 當前 hunk
- `[c`/`]c` - 在變更間跳轉
- `<Space>hr` - 重置變更

### 5. AI 助手 (Claude Code)

1. `<Space>Cc` - 切換 Claude Code 視窗
2. `<Space>Ca` - 添加當前文件到上下文
3. `<Space>Cs` - 發送選取內容（Visual 模式）
4. `<Space>Cy` - 接受 AI 的修改
5. `<Space>Cn` - 拒絕 AI 的修改

### 6. 會話管理

**工作流程**:
1. 在專案目錄啟動 Neovim
2. 開啟檔案、設定視窗佈局
3. 退出時自動保存會話
4. 下次啟動時：
   - 看到首頁（mini.starter）
   - `<Space>Ss` - 恢復上次會話
   - `<Space>Sl` - 選擇其他會話

---

## 🔮 未來功能規劃

### 🚧 計畫中（短期）

#### 1. 測試框架整合
- [ ] **neotest** - 統一的測試介面
  - 支援 Jest、Vitest、pytest 等
  - 快捷鍵: `<Space>tr` 執行測試、`<Space>ts` 查看摘要
  - 顯示測試覆蓋率

#### 2. 資料庫工具
- [ ] **vim-dadbod** + **vim-dadbod-ui** - 資料庫管理
  - 直接在 Neovim 中查詢資料庫
  - 支援 PostgreSQL、MySQL、SQLite
  - 快捷鍵: `<Space>db` 開啟資料庫 UI

#### 3. REST API 測試
- [ ] **rest.nvim** - HTTP 客戶端
  - 在 `.http` 檔案中測試 API
  - 快捷鍵: `<Space>rr` 執行請求
  - 查看回應和歷史記錄

#### 4. 專案管理增強
- [ ] **project.nvim** - 專案切換
  - 快速在多個專案間切換
  - 記住每個專案的會話
  - 快捷鍵: `<Space>fp` 搜尋專案

#### 5. 性能優化工具
- [ ] **vim-startuptime** - 分析啟動時間
- [ ] **profile.nvim** - 性能分析
- [ ] 優化 lazy loading 配置

### 🌟 考慮中（中期）

#### 1. 進階 LSP 功能
- [ ] **Copilot.vim** 或 **CodeCompanion** - AI 補全
- [ ] **typescript-tools.nvim** - 增強 TypeScript 支援
- [ ] **nvim-jdtls** - Java 開發支援
- [ ] **rust-tools.nvim** - Rust 開發支援

#### 2. UI/UX 改進
- [ ] **indent-blankline.nvim** - 縮排線（可能與 mini.indentscope 衝突）
- [ ] **fidget.nvim** - LSP 進度顯示
- [ ] **nvim-scrollbar** - 捲動條
- [ ] **todo-ui.nvim** - TODO 管理面板

#### 3. 文件與註解
- [ ] **markdown-preview.nvim** - Markdown 即時預覽
- [ ] **peek.nvim** - Markdown 預覽（原生）
- [ ] **dooku.nvim** - 文檔生成器

#### 4. 代碼品質
- [ ] **nvim-lint** - Linter 整合
- [ ] **conform.nvim** - 格式化工具
- [ ] **refactoring.nvim** - 重構工具

### 🔬 實驗性（長期）

#### 1. 擴展語言支援
- [ ] Go 開發環境完整配置
- [ ] Rust 開發環境完整配置
- [ ] Java 開發環境完整配置
- [ ] C/C++ 開發環境完整配置

#### 2. 工作流程自動化
- [ ] 自訂代碼片段模板系統
- [ ] 專案腳手架生成器
- [ ] Git hooks 整合

#### 3. 協作功能
- [ ] **instant.nvim** - 即時協作編輯
- [ ] **vim-wakatime** - 時間追蹤

#### 4. 桌面整合
- [ ] **neovide** - GUI 前端
- [ ] **vscode-neovim** - VSCode 整合

### ⚠️ 不計畫添加的功能

以下功能已有更好的替代方案或與現有配置衝突：

| 功能 | 原因 | 替代方案 |
|------|------|---------|
| coc.nvim | 與原生 LSP 衝突 | nvim-lspconfig |
| NERDTree | 功能重複 | nvim-tree.lua |
| fzf.vim | 功能重複 | telescope.nvim |
| vim-airline | 功能重複 | lualine.nvim |
| vimwiki | 專案定位不符 | 外部筆記工具 |

### 📋 待評估的功能

需要更多使用者反饋：

- [ ] **nvim-spectre** vs **grug-far** - 哪個搜尋替換更好用？
- [ ] **leap.nvim** vs **mini.jump2d** - 哪個跳轉體驗更好？
- [ ] **harpoon** - 檔案快速標記，是否需要？
- [ ] **oil.nvim** - 檔案管理器替代方案

### 🤝 如何建議新功能

1. 開啟 GitHub Issue
2. 描述功能用途和使用場景
3. 說明是否有類似插件可參考
4. 如可能，提供配置範例

---

## ❓ 常見問題

### Q: 如何更新所有插件？

```vim
:Lazy sync
```

### Q: 補全不工作怎麼辦？

1. 檢查 LSP 狀態: `:LspInfo`
2. 檢查 Mason 狀態: `:Mason`
3. 重啟 Neovim
4. 執行健康檢查: `:checkhealth lsp`

### Q: TreeSitter 語法高亮異常？

```vim
:TSUpdate
:checkhealth nvim-treesitter
```

### Q: 如何更改主題？

編輯 `lua/core/options.lua` 第 32 行:

```lua
vim.cmd([[colorscheme your-theme-name]])
```

### Q: 如何禁用某個插件？

在插件配置檔案中添加 `enabled = false`:

```lua
return {
    "plugin-name",
    enabled = false,  -- 添加這行
}
```

或直接刪除該插件的 `.lua` 檔案。

### Q: 啟動速度慢怎麼辦？

1. 檢查啟動時間:
   ```vim
   :Lazy profile
   ```

2. 優化 lazy loading 配置
3. 考慮禁用不常用的插件

### Q: Windows 上 PowerShell 終端問題？

`toggleterm.lua` 已自動配置使用 PowerShell。如果有問題：

```lua
-- 編輯 lua/plugins/toggleterm.lua
shell = "powershell"  -- 或 "pwsh" (PowerShell 7+)
```

### Q: 如何添加自訂快捷鍵？

**方法 1**: 在 `core/keymaps.lua` 添加核心快捷鍵

**方法 2**: 在插件的 `keys` 參數中添加

**方法 3**: 在 `which-key.lua` 註冊快捷鍵說明

### Q: 會話管理干擾我的工作流程？

已將 `autoread` 設為 `false`，啟動時顯示首頁。

如需完全禁用會話管理，在 `mini-sessions.lua` 中設定:
```lua
autowrite = false,  -- 不自動保存
```

### Q: mini.nvim 系列插件太多了？

mini.nvim 的設計理念是模塊化，每個插件功能單一。你可以：
- 只使用需要的 mini 插件
- 用其他插件替換（如 Comment.nvim 替換 mini.comment）

---

## 🤝 貢獻

歡迎貢獻！如果你有改進建議：

1. Fork 此專案
2. 創建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

### 貢獻指南

- 保持配置的模塊化結構
- 為新插件添加詳細註釋
- 更新 README 和 CLAUDE.md
- 測試配置在多個平台上的相容性

---

## 📄 授權

MIT License

---

## 🙏 致謝

感謝所有插件作者的辛勤付出！

特別感謝：
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - 插件管理器
- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim) - Mini 系列插件
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - 模糊搜尋
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP 配置

---

**⭐ 如果這個配置對你有幫助，請給個 Star！**

**💬 有問題？開啟 Issue 討論！**

**🔧 想要改進？歡迎 PR！**
