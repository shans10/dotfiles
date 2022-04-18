local M = {}

function M.config()
  local g = vim.g

  g.dashboard_default_executive = "telescope"

  --- HEADER ---
  --
  g.dashboard_custom_header = {
    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'                                                     `' |  /==.||]],
    [[=='    _-'                        N E O V I M                         \/   `==]],
    [[\   _-'                                                                `-_   /]],
    [[ `''                                                                      ``' ]],
  }

  --- MAPPINGS ---
  --
  g.dashboard_custom_section = {
    a = { description = { "   Reload Last Session             SPC r l" }, command = "SessionManager load_last_session" },
    b = { description = { "   Find File                       SPC f f" }, command = "Telescope find_files" },
    c = { description = { "   Recent Files                    SPC f o" }, command = "Telescope oldfiles" },
    d = { description = { "   New File                        SPC f n" }, command = "DashboardNewFile" },
    e = { description = { "   Projects                        SPC s p" }, command = "Telescope projects" },
    f = { description = { "   User Configuration              SPC u c" }, command = "exe \"edit\" stdpath(\"config\").\"/lua/user/init.lua\"" },
  }

  --- FOOTER ---
  --
  local total_plugins = "   " .. #vim.tbl_keys(packer_plugins) .. " plugins  "   -- Total number of plugins
  local time = " " .. os.date("%H:%M")
  local date = " " .. os.date("%d-%m-%y")

  g.dashboard_custom_footer = {
    total_plugins
    .. " v"
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
    .. "  "
    .. time
    .. "  "
    .. date
  }
end

return M
