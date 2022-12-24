return {
  opt = {
    list = true, -- enable whitespace rendering
    -- listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
    listchars = vim.opt.listchars:append({ tab = '› ', trail = '•' }), -- change whitespace characters
    whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
    title = true,
    titlestring = "Neovim: %f"
  },
  g = {
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    heirline_bufferline = true, -- enable new heirline based bufferline (requires :PackerSync after changing)
    heirline_theme = "doom", -- set heirline statusline theme (possible options are doom, lunarvim, nvchad), comment/remove this option to choose default astronvim statusline
  }
}
