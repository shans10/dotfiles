local M = {}

function M.config()
  local g = vim.g
  local fn = vim.fn

  local plugins_count = fn.len(vim.fn.globpath(fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))

  g.dashboard_disable_statusline = 1
  g.dashboard_default_executive = "telescope"
  g.dashboard_custom_header = {
    " ",
    " ",
    " ",
    " ",
    " ",
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "         ██    ██ ██ ███    ███",
    "         ██    ██ ██ ████  ████",
    "         ██    ██ ██ ██ ████ ██",
    "          ██  ██  ██ ██  ██  ██",
    "           ████   ██ ██      ██",
    " ",
    " ",
    " ",
  }

  g.dashboard_custom_section = {
    a = { description = { "   Find File                 SPC f f" }, command = "Telescope find_files" },
    b = { description = { "   Recent Files              SPC f o" }, command = "Telescope oldfiles" },
    c = { description = { "   New File                  SPC f n" }, command = "DashboardNewFile" },
    d = { description = { "   Search Text               SPC s t" }, command = "Telescope live_grep" },
    e = { description = { "   Bookmarks                 SPC b m" }, command = "Telescope marks" },
    f = { description = { "   User Configuration        SPC u c" }, command = "e /home/$USER/.config/nvim/lua/user/init.lua" },
    g = { description = { "   Last Session              SPC S L" }, command = "SessionManager load_last_session" },
    h = { description = { "   Projects                  SPC   P" }, command = "Telescope projects" },
  }

  g.dashboard_custom_footer = {
    " ",
    " AstroVim loaded " .. plugins_count .. " plugins ",
  }
end

return M
