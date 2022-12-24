--- HEADERS ---
--
local header = {
  "                                                                              ",
  "=================     ===============     ===============   ========  ========",
  "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
  "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
  "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
  "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
  "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
  "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
  "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
  "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
  "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
  "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
  "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
  "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
  "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
  "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
  "||.=='    _-'                                                     `' |  /==.||",
  "=='    _-'                        N E O V I M                         \\/   `==",
  "\\   _-'                                                                `-_   /",
  " `''                                                                      ``'  ",
}

-- local header = {
--   " █████  ███████ ████████ ██████   ██████",
--   "██   ██ ██         ██    ██   ██ ██    ██",
--   "███████ ███████    ██    ██████  ██    ██",
--   "██   ██      ██    ██    ██   ██ ██    ██",
--   "██   ██ ███████    ██    ██   ██  ██████",
--   " ",
--   "    ███    ██ ██    ██ ██ ███    ███",
--   "    ████   ██ ██    ██ ██ ████  ████",
--   "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
--   "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
--   "    ██   ████   ████   ██ ██      ██",
-- }

-- local header = {
--   [[                                                                            ]],
--   [[   ████████╗███████╗██╗   ██╗██╗  ██╗██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗   ]],
--   [[   ╚══██╔══╝██╔════╝██║   ██║██║ ██╔╝██║████╗  ██║██║   ██║██║████╗ ████║   ]],
--   [[      ██║   ███████╗██║   ██║█████╔╝ ██║██╔██╗ ██║██║   ██║██║██╔████╔██║   ]],
--   [[      ██║   ╚════██║██║   ██║██╔═██╗ ██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║   ]],
--   [[      ██║   ███████║╚██████╔╝██║  ██╗██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║   ]],
--   [[      ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝   ]],
--   [[                                                                            ]],
--   [[                                [Tsuki ga Kirei]                            ]],
-- }

--- FOOTER ---
--
local total_plugins = #vim.tbl_keys(packer_plugins) -- total number of plugins

return {
  layout = {
    -- { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
    { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.13) } },
    {
      type = "text",
      val = header,
      opts = { position = "center", hl = "DashboardHeader" },
    },
    { type = "padding", val = 3 },
    {
      type = "group",
      val = {
        astronvim.alpha_button("LDR S l", astronvim.get_icon("Reload") .. "  Reload last session  "),
        astronvim.alpha_button("LDR f r", astronvim.get_icon("FileRecent") .. "  Recently opened files  "),
        astronvim.alpha_button("LDR f f", astronvim.get_icon("Find") .. "  Find file  "),
        astronvim.alpha_button("LDR f n", astronvim.get_icon("FileNew") .. "  New file  "),
        astronvim.alpha_button("LDR s p", astronvim.get_icon("Project") .. "  Open project  "),
        astronvim.alpha_button("LDR s m", astronvim.get_icon("BookMark") .. "  Jump to bookmark  "),
      },
      opts = { position = "center", spacing = 1 },
    },
    { type = "padding", val = 3 },
    {
      type = "text",
      val = {
        astronvim.get_icon("Plugin")
            .. " Neovim loaded with total "
            .. total_plugins
            .. " plugins"
      },
      opts = { position = "center", hl = "DashboardFooter" },
    },
  },
  opts = { noautocmd = true },
}
