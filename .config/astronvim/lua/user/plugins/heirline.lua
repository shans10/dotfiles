local heirline = function(config)
  -- List of supported themes to match with currently selected theme
  local themes = { ["doom"] = true, ["lunarvim"] = true, ["nvchad"] = true }

  -- Get current statusline theme, set it to "astronvim" if it is nil
  local theme = vim.g.heirline_theme

  -- If theme is not set or set to an unsupported theme, then return default statusline
  if not themes[theme] then
    config[1] = config[1]
  else
    -- Set statusline based on chosen theme
    config[1] = require("user.plugins.heirline.themes." .. theme)
  end

  return config
end

return heirline
