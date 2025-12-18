return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "診斷列表 (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "當前文件診斷 (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "符號大綱 (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP 定義/引用 (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xt",
            "<cmd>Trouble todo toggle<cr>",
            desc = "TODO 列表 (Trouble)",
        },
        {
            "<leader>xT",
            "<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME}}<cr>",
            desc = "TODO/FIX/FIXME (Trouble)",
        },
        {
            "[x",
            function()
                require("trouble").prev({ skip_groups = true, jump = true })
            end,
            desc = "上一個問題 (Trouble)",
        },
        {
            "]x",
            function()
                require("trouble").next({ skip_groups = true, jump = true })
            end,
            desc = "下一個問題 (Trouble)",
        },
    },
    opts = {
        modes = {
            -- 自定義模式：只顯示錯誤
            errors = {
                mode = "diagnostics",
                filter = {
                    severity = vim.diagnostic.severity.ERROR,
                },
            },
            -- 自定義模式：只顯示警告
            warnings = {
                mode = "diagnostics",
                filter = {
                    severity = vim.diagnostic.severity.WARN,
                },
            },
        },
        -- 圖標設置
        icons = {
            indent = {
                top = "│ ",
                middle = "├╴",
                last = "└╴",
                fold_open = " ",
                fold_closed = " ",
                ws = "  ",
            },
            folder_closed = " ",
            folder_open = " ",
            kinds = {
                Array = " ",
                Boolean = "󰨙 ",
                Class = " ",
                Constant = "󰏿 ",
                Constructor = " ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = " ",
                Function = "󰊕 ",
                Interface = " ",
                Key = " ",
                Method = "󰊕 ",
                Module = " ",
                Namespace = "󰦮 ",
                Null = " ",
                Number = "󰎠 ",
                Object = " ",
                Operator = " ",
                Package = " ",
                Property = " ",
                String = " ",
                Struct = "󰆼 ",
                TypeParameter = " ",
                Variable = "󰀫 ",
            },
        },
        -- 自動預覽
        auto_preview = true,
        -- 自動跳轉
        auto_jump = false,
        -- 焦點設置
        focus = true,
        -- 窗口設置
        win = {
            type = "split",
            position = "bottom",
            size = 0.3,
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        -- 整合 todo-comments.nvim
        -- 當使用 Telescope 搜尋 TODO 時，結果會在 trouble 中顯示
        local trouble = require("trouble")

        -- 添加自定義命令
        vim.api.nvim_create_user_command("TroubleErrors", function()
            trouble.open("errors")
        end, { desc = "只顯示錯誤" })

        vim.api.nvim_create_user_command("TroubleWarnings", function()
            trouble.open("warnings")
        end, { desc = "只顯示警告" })
    end,
}
