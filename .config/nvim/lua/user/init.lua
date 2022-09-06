local config = {

  -- Configure DoomNvim updates
  updater = {
    pin_plugins = false, -- lock plugins to commits provided in pavker_snapshot
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = true, -- automatically quit the current session after a successful update
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      list = true, -- enable whitespace rendering
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
    },
    g = {
      remove_trailing_whitespace = true, -- remove trailing whitespaces by default
    },
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- Disable default plugins
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["windwp/nvim-ts-autotag"] = { disable = true },
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "python", "c", "cpp", "haskell" },   -- automatically install these treesitters
    },

    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },   -- automatically install these LSPs
    },

    toggleterm = {
      shell = "fish",   -- set toggleterm shell
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = false,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      "pyright",
      "clangd",
      "hls"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
      -- Example disabling formatting for a specific language server
      -- gopls = { -- override table for require("lspconfig").gopls.setup({...})
      --   on_attach = function(client, bufnr)
      --     client.resolved_capabilities.document_formatting = false
      --   end
      -- }
    },
  },

  -- This function is run last
  -- good place to configure augroups/autocommands and custom filetypes
  polish = function()
    -- Nvui Settings
    if vim.g.nvui then
      -- Configure through vim commands
      vim.cmd [[set guifont=Cascadia\ Code:h11]]
      -- vim.cmd [[NvuiCursorAnimationDuration 0.1]]
    end
  end,
}

return config
