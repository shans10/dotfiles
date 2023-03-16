return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    dim_inactive = { enabled = true, percentage = 0.35 },
    custom_highlights = function(colors)
      return {
        -- Line numbers
        CursorLineNr = { bold = true },
        -- LineNr = { italic = true },

        -- Indent blankline
        IndentBlanklineContextChar = { fg = colors.flamingo },
        -- IndentBlanklineContextStart = { sp = colors.flamingo },
      }
    end,
    integrations = {
      aerial = true,
      dap = { enabled = true, enable_ui = true },
      mason = true,
      neotree = true,
      notify = true,
      nvimtree = false,
      sandwich = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  }
}
