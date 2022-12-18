return function()
  local blue = astronvim.get_hlgroup("Directory").fg
  local grey = astronvim.get_hlgroup("NonText").fg
  local red = astronvim.get_hlgroup("Error").fg
  return {
    DashboardCenter = { fg = red, italic = true },
    DashboardFooter = { fg = grey, italic = true },
    DashboardHeader = { fg = grey, italic = true },
    DashboardShortcut = { fg = blue, italic = false },
    HighlightURL = { underline = true }
  }
end
