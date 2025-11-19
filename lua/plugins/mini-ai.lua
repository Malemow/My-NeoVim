return {
  "echasnovski/mini.ai",
  version = false,
  event = "VeryLazy",
  config = function()
    local ai = require("mini.ai")
    ai.setup({
      -- Table with textobject id as fields, textobject specification as values
      custom_textobjects = {
        -- Whole buffer
        g = function()
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
      },
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",
        -- Next/last variants
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
      },
      -- Number of lines within which textobject is searched
      n_lines = 50,
    })
  end,
}
