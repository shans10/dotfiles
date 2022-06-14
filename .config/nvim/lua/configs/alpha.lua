local M = {}

function M.config()
  local present, alpha = pcall(require, "alpha")
  if present then
    local alpha_button = doomnvim.alpha_button

    -- Footer
    local total_plugins = "   " .. #vim.tbl_keys(packer_plugins) .. " plugins  "   -- Total number of plugins
    local time = " " .. os.date("%H:%M")
    local date = " " .. os.date("%d-%m-%y")

    alpha.setup(doomnvim.user_plugin_opts("plugins.alpha", {
      layout = {
        { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
        {
          type = "text",
          val = doomnvim.user_plugin_opts("header", {
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
          }, false),
          opts = { position = "center", hl = "DashboardHeader" },
        },
        { type = "padding", val = 5 },
        {
          type = "group",
          val = {
            alpha_button("LDR S l", "  Reload Last Session  "),
            alpha_button("LDR f f", "  Find File  "),
            alpha_button("LDR f o", "  Recent Files  "),
            alpha_button("LDR f n", "  New File  "),
            alpha_button("LDR   P", "  Projects  "),
            alpha_button("LDR   u", "  User Configuration  "),
          },
          opts = { spacing = 1 },
        },
        {
          type = "text",
          val = {
            " ",
            " ",
            " ",
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
          },
          opts = {
            position = "center",
            hl = "DashboardFooter",
          },
        },
      },
      opts = {},
    }))
  end
end

return M
