local st = astronvim.status

-- An `init` function to build a set of children components for LSP breadcrumbs
local function breadcrumbs_init(opts)
  opts = astronvim.default_tbl(opts, {
    separator = " > ",
    icon = { enabled = true, hl = astronvim.status.env.icon_highlights.breadcrumbs },
    padding = { left = 0, right = 0 },
  })
  return function(self)
    local data = require("aerial").get_location(true) or {}
    local children = {}
    -- create a child for each level
    for _, d in ipairs(data) do
      local pos = astronvim.status.utils.encode_pos(d.lnum, d.col, self.winnr)
      local child = {
        { provider = string.gsub(d.name, "%%", "%%%%"):gsub("%s*->%s*", "") }, -- add symbol name
        on_click = { -- add on click function
          minwid = pos,
          callback = function(_, minwid)
            local lnum, col, winnr = astronvim.status.utils.decode_pos(minwid)
            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { lnum, col })
          end,
          name = "heirline_breadcrumbs",
        },
      }
      if opts.icon.enabled then -- add icon and highlight if enabled
        local hl = opts.icon.hl
        if type(hl) == "function" then hl = hl(self) end
        table.insert(child, 1, {
          provider = string.format("%s ", d.icon),
          hl = hl and string.format("Aerial%sIcon", d.kind) or nil,
        })
      end
      table.insert(child, 1, { provider = opts.separator }) -- add a separator before element
      table.insert(children, child)
    end
    if opts.padding.left > 0 then -- add left padding
      table.insert(children, 1, { provider = astronvim.pad_string(" ", { left = opts.padding.left - 1 }) })
    end
    if opts.padding.right > 0 then -- add right padding
      table.insert(children, { provider = astronvim.pad_string(" ", { right = opts.padding.right - 1 }) })
    end
    -- instantiate the new child
    self[1] = self:new(children, 1)
  end
end

return {
  -- default highlight for the entire winbar
  hl = { fg = "winbar_fg" },
  -- disable winbar for certain filetypes
  static = {
    disabled = {
      buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
      filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
    },
  },
  init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
  {
    condition = function(self)
      return vim.opt.diff:get() or st.condition.buffer_matches(self.disabled or {})
    end,
    init = function() vim.opt_local.winbar = nil end,
  },
  -- add a component to show filename
  st.component.file_info {
    unique_path = {},
    file_icon = { hl = st.hl.file_icon "winbar" },
    file_modified = false,
    file_read_only = false,
    hl = st.hl.get_attributes("winbar", true),
    surround = false,
    update = "BufEnter",
  },
  -- add a component to show breadcrumbs
  st.component.builder {
    condition = function() return st.condition.is_active() end,
    init = breadcrumbs_init()
  }
}
