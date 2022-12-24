local icons = {
  ActiveTS1 = "",
  BookMark = "",
  FileNew = "",
  FileRecent = "",
  Find = "",
  GitBranch = "",
  Plugin = "",
  Project = "",
  Reload = "",
}

-- Set icons based on chosen heirline-statusline theme
--
-- Get current statusline theme
local heirline_theme = vim.g.heirline_theme

-- Doom theme
if heirline_theme == "doom" then
  icons.ActiveLSP = ""
  icons.Bar = "┃"
  icons.Directory = ""
  icons.DoomMode = ""
  icons.EvilMode = ""
  icons.FileModified = ""
  icons.GitBranchModified = ""
  icons.GitChanges = ""

-- Lunarvim theme
elseif heirline_theme == "lunarvim" then
  icons.DefaultFile = ""
  icons.Mode = ""
  icons.Separator = "|"
  icons.Shiftwidth = ""

-- Nvchad theme
elseif heirline_theme == "nvchad" then
  icons.VimIcon = ""
  icons.ScrollText = ""
  icons.GitBranch = ""
  icons.GitAdd = ""
  icons.GitChange = ""
  icons.GitDelete = ""
end

return icons
