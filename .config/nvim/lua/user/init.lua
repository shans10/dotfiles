local config = {

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      list = true, -- Enable whitespace rendering
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- Change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- Automatically go to next line
    },
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- Disable default plugins
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["windwp/nvim-ts-autotag"] = { disable = true },

      -- Add user plugins
      ["lambdalisue/suda.vim"] = {},
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "python", "c", "cpp" },   -- Automatically install these TreeSitters
    },

    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },   -- Automatically install these LSPs
    },

    toggleterm = {
      shell = "fish",   -- Set ToggleTerm Shell
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = false,
  },

  -- This function is run last
  -- good place to configure augroups/autocommands and custom filetypes
  polish = function()
    -- Nvui Settings
    if vim.g.nvui then
      -- Configure through vim commands
      vim.cmd [[set guifont=Cascadia\ Code:h11,JetBrainsMono\ Nerd\ Font]]
      vim.cmd [[NvuiCursorAnimationDuration 0.1]]
    end
  end,
}

return config
