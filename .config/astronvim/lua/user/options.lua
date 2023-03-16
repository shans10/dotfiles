return {
  opt = {
    list = true, -- enable whitespace rendering
    -- listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
    listchars = vim.opt.listchars:append({ tab = '› ', trail = '•' }), -- change whitespace characters
    showtabline = 0, -- disable tabline (also set vim.g.tabline accordingly { true for 1, 2 or false for 0 })
    title = true, -- enable neovim to set terminal title
    titlestring = "Neovim: %f", -- set titlestring to be displayed
    whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
  },
  g = {
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    tabline = false, -- enable/disable functionality based on tabline (false if vim.opt.showtabline is set to '0', else true)
    -- heirline_theme = "lunarvim", -- set heirline statusline theme (possible options are doom, lunarvim, nvchad), comment/remove this option to choose default astronvim statusline
    winbar_enabled = true, -- enable winbar (set false to disable it, removing this option will have no effect)
  }
}
