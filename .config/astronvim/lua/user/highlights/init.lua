return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  local blue = get_hlgroup("Directory").fg
  local grey = get_hlgroup("NonText").fg
  local red = get_hlgroup("Error").fg
  return {
    DashboardCenter = { fg = red, italic = true },
    DashboardFooter = { fg = grey, italic = true },
    DashboardHeader = { fg = grey, italic = true },
    DashboardShortcut = { fg = blue, italic = false },
    HighlightURL = { underline = true }
  }
end
