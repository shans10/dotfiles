local st = require "user.plugins.heirline.status"
local component = {}

component.breadcrumbs = {
  condition = st.condition.aerial_available,
  init = st.init.breadcrumbs()
}

component.filename = {
  { provider = st.provider.file_icon { padding = { left = 1, right = 1 } }, hl = st.hl.filetype_color },
  { provider = st.provider.filename() },
  { provider = "%<" }
}

local winbar = {
  fallthrough = false,
  {
    condition = function()
      return st.condition.buffer_matches {
        buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
        filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial", "qf" },
      }
    end,
    init = function() vim.opt_local.winbar = nil end,
  },
  {
    hl = { fg = "normal_fg" },
    component.filename,
    component.breadcrumbs
  }
}

return winbar
