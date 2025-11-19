return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    {
      "<leader>cgf",
      function()
        require("neogen").generate({ type = "func" })
      end,
      desc = "生成函數註解",
    },
    {
      "<leader>cgc",
      function()
        require("neogen").generate({ type = "class" })
      end,
      desc = "生成類別註解",
    },
    {
      "<leader>cgt",
      function()
        require("neogen").generate({ type = "type" })
      end,
      desc = "生成類型註解",
    },
    {
      "<leader>cgF",
      function()
        require("neogen").generate({ type = "file" })
      end,
      desc = "生成文件註解",
    },
  },
  opts = {
    enabled = true,
    snippet_engine = "luasnip",
    languages = {
      lua = {
        template = {
          annotation_convention = "ldoc",
        },
      },
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
      typescript = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
      javascript = {
        template = {
          annotation_convention = "jsdoc",
        },
      },
      go = {
        template = {
          annotation_convention = "godoc",
        },
      },
      rust = {
        template = {
          annotation_convention = "rustdoc",
        },
      },
    },
  },
}
