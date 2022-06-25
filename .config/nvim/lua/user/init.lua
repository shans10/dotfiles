local config = {

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
      shell = "nu",   -- Set ToggleTerm Shell
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = false,
  },

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    --- SET OPTIONS ---
    --
    -- Render tabs/trailing spaces
    vim.opt.listchars:append({ tab = '› ', trail = '•', extends = '#', nbsp = '.' })

    -- Automatically go to next line
    vim.opt.whichwrap:append "<,>[,],h,l"
  end,
}

return config
