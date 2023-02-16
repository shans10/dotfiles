require("catppuccin").setup({
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
    neotree = true,
    notify = true,
    treesitter = true,
    which_key = true
  },
})
