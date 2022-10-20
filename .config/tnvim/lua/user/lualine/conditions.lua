local window_width_limit = 100

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,

  hide_in_width = function()
    return vim.o.columns > window_width_limit
  end,

  valid_filename = function()
    return not tnvim.status.condition.buffer_matches {
      buftype = { "nofile", "prompt", "quickfix" },
      filetype = { "^git.*", "fugitive", "toggleterm", "NvimTree" },
    }
  end
}

return conditions
