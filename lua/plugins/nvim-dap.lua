return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      -- Virtual text support
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      -- Mason integration for debuggers
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason.nvim" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            -- Add debuggers you want to install here
          },
        },
      },
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "切換中斷點",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "條件中斷點",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "繼續執行/開始調試",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "步入",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "步過",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "步出",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "切換 REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "重新執行上次調試",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "終止調試",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "切換調試 UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "v" },
        desc = "評估表達式",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup dapui
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- Auto open/close dapui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Icons
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStopped", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end,
  },
}
