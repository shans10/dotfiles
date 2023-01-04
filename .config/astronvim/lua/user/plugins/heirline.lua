local heirline = function(config)
  -- List of supported themes to match with currently selected theme
  local themes = { ["doom"] = true, ["lunarvim"] = true, ["nvchad"] = true }

  -- Get current statusline theme, set it to "astronvim" if it is nil
  local theme = vim.g.heirline_theme

  -- Override statusline configuration
  -- Set statusline based on chosen theme
  if themes[theme] then
    config[1] = require("user.plugins.heirline.themes." .. theme)
  end

  -- Override winbar configuration
  if theme == "lunarvim" then
    config[2] = require "user.plugins.heirline.winbar"
  elseif vim.g.winbar_enabled == false then
    config[2] = nil
  end

  return config
end

return heirline
