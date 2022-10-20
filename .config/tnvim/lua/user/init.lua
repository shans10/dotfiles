local config = {

  -- Set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      list = true, -- enable whitespace rendering
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      "pyright",
      "clangd",
      "hls",
      "bashls",
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

      -- Statusline
      ["rebelot/heirline.nvim"] = {
        event = "ColorScheme",
        config = function() require "user.heirline" end,
      },

      -- Install and setup user plugins
      --
      -- Statusline
      -- ["nvim-lualine/lualine.nvim"] = {
      --   event = "ColorScheme",
      --   config = function() require "user.lualine" end,
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

    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" }, -- automatically install these LSPs
    },

    toggleterm = {
      shell = "fish", -- set toggleterm shell
    },
  },

  -- This function is run last
  -- good place to configure augroups/autocommands and custom filetypes
  polish = function()
    -- Glrnvim Settings
    if vim.g.glrnvim_gui then
      vim.cmd "Alpha" -- load alpha-dashboard on startup
    end
  end,
}

return config
