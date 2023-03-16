return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    -- List of supported themes to match with currently selected theme
    local themes = { ["doom"] = true, ["lunarvim"] = true, ["nvchad"] = true }

    -- Get current statusline theme, set it to "astronvim" if it is nil
    local theme = vim.g.heirline_theme

    -- Override statusline configuration
    -- Set statusline based on chosen theme
    if themes[theme] then
      opts.statusline = require("user.plugins.heirline.themes." .. theme)
    end

    -- Override winbar configuration
    if vim.g.winbar_enabled == false then
      opts.winbar = nil
    elseif (theme == "lunarvim" or not themes[theme]) and not vim.g.tabline then
      opts.winbar = require "user.plugins.heirline.winbar"
    end

    -- return the final configuration table
    return opts
  end,
}
