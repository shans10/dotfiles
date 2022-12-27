return {
  opt = {
    list = true, -- enable whitespace rendering
    -- listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
    listchars = vim.opt.listchars:append({ tab = '› ', trail = '•' }), -- change whitespace characters
    showtabline = 0, -- disable tabline
    title = true, -- enable neovim to set terminal title
    titlestring = "Neovim: %f", -- set titlestring to be displayed
    whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
  },
  g = {
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
    -- heirline_theme = "nvchad", -- set heirline statusline theme (possible options are doom, lunarvim, nvchad), comment/remove this option to choose default astronvim statusline
  }
}
