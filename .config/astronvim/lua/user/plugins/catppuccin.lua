require("catppuccin").setup({
  custom_highlights = function(colors)
    return {
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
