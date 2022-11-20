local config = {

  -- Set colorscheme to use
  -- colorscheme = "catppuccin",

  -- Set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      list = true, -- enable whitespace rendering
      -- listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•' }), -- change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
      -- showtabline = 0,
    },
    g = {
      autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      -- catppuccin_flavour = "mocha",
    }
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      "pyright",
      "clangd",
      "bashls",
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "lua",
          -- "python",
        },
      },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  mappings = {
    n = {
      -- NvimTree
      ["<C-n>"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },

      -- Terminal
      ["<leader>tt"] = { "<cmd>!alacritty<cr><cr>", desc = "Open alacritty in cwd" },

      -- Buffer
      ["<A-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
      ["<A-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },
    },
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- Disable/reconfigure default plugins
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["windwp/nvim-ts-autotag"] = { disable = true },
      -- ["akinsho/bufferline.nvim"] = { disable = true },

      -- Statusline
      ["rebelot/heirline.nvim"] = {
        event = "ColorScheme",
        config = function() require "user.heirline" end,
        -- disable = true
      },

      -- Install and setup user plugins
      --
      -- Statusline
      -- ["nvim-lualine/lualine.nvim"] = {
      --   event = "ColorScheme",
      --   config = function() require "user.lualine" end,
      -- },

      -- Theme
      -- ["catppuccin/nvim"] = {
      --  as = "catppuccin",
      --  config = function() require("catppuccin").setup() end
      -- },

      -- Remember last position in a file
      ["ethanholz/nvim-lastplace"] = {
        config = function() require "user.lastplace" end
      },

      -- Highlight f/F jumps
      ["jinh0/eyeliner.nvim"] = {
        config = function() require "user.eyeliner" end
      }
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "python", "c", "cpp", "haskell", "bash" }, -- automatically install these treesitters
    },

    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = {
      ensure_installed = { "sumneko_lua" },
    },

    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    -- ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    -- },

    toggleterm = {
      shell = "fish", -- set toggleterm shell
    },

    bufferline = {
      options = {
        show_duplicate_prefix = false,
      }
    }
  },

  -- This function is run last
  -- good place to configure augroups/autocommands and custom filetypes
  polish = function()
    -- Glrnvim Settings
    if vim.g.glrnvim_gui then
      vim.cmd [[
        set nobuflisted
        Alpha
      ]]
    end
  end,
}

return config
