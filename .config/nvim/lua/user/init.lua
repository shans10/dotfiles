local config = {

  -- Configure TsukiNvim updates
  updater = {
    pin_plugins = false, -- lock plugins to commits provided in pavker_snapshot
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = true, -- automatically quit the current session after a successful update
  },

  -- Set colorscheme to use
  -- colorscheme = "elflord",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      list = true, -- enable whitespace rendering
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
    },
    g = {
      strip_trailing_ws = false, -- remove trailing whitespaces on file save
      catppuccin_flavour = "mocha"
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
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- NvimTree
      ["<C-/>"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },

      -- Terminal
      ["<leader>tt"] = { "<cmd>!alacritty<cr><cr>", desc = "Open alacritty in cwd" },

      -- Buffer
      ["<C-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
      ["<C-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },
    },
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- Disable default plugins
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["windwp/nvim-ts-autotag"] = { disable = true },

      -- Install and setup user plugins
      --
      -- Remeber last position in a file
      ["ethanholz/nvim-lastplace"] = {
        config = function() require 'nvim-lastplace'.setup {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true
          }
        end
      },

      -- Character based movement
      ["phaazon/hop.nvim"] = {
        branch = 'v2', -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
      },
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
    -- Hop.nvim
    vim.api.nvim_set_keymap('', 'f',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 'F',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 't',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 'T',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
      , {})

    -- Nvui Settings
    if vim.g.nvui then
      -- Configure through vim commands
      vim.cmd [[set guifont=Cascadia\ Code:h11]]
      -- vim.cmd [[NvuiCursorAnimationDuration 0.1]]
    end
  end,
}

return config
