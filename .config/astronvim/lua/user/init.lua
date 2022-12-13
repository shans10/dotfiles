local config = {

  -- Set colorscheme to use
  colorscheme = "catppuccin",

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      list = true, -- enable whitespace rendering
      -- listchars = vim.opt.listchars:append({ tab = '› ', trail = '•', lead = '.', extends = '#', nbsp = '.' }), -- change whitespace characters
      listchars = vim.opt.listchars:append({ tab = '› ', trail = '•' }), -- change whitespace characters
      whichwrap = vim.opt.whichwrap:append "<,>[,],h,l", -- automatically go to next line
    },
    g = {
      autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    }
  },

 -- Set dashboard header
  header = {
    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'                                                     `' |  /==.||]],
    [[=='    _-'                        N E O V I M                         \/   `==]],
    [[\   _-'                                                                `-_   /]],
    [[ `''                                                                      ``' ]],
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      "bashls",
      "clangd",
      "hls",
      "pyright",
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        ["<leader>ld"] = false, -- disable hover diagnostic keymap
        ["<leader>ll"] = { function() vim.diagnostic.open_float() end, desc = "Show line diagnostics" },
        ["gh"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" }
      },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  mappings = {
    n = {
      --- STANDARD LEADER KEY OPERATIONS ---
      --
      ["<leader>C"] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD to file" },

      --- FILE EXPLORER ---
      --
      -- Neo-tree
      ["<C-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle nvim-tree" },

      --- TERMINAL ---
      --
      -- External terminal
      ["<leader>tt"] = { "<cmd>!alacritty<cr><cr>", desc = "Open alacritty in cwd" },

      -- ToggleTerm
      ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

      --- BUFFER ---
      --
      -- Buffer Standalone Keybindings
      ["<leader>ba"] = { "<cmd>silent! %bd|e#|bd#<cr>", desc = "Close all but current buffer" },
      ["<leader>bl"] = { "<C-6>", desc = "Last buffer" },

      -- Bufdelete
      ["<leader>c"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Close buffer" },
      ["<leader>bd"] = { "<cmd>Bdelete<cr>", desc = "Delete" },
      ["<leader>bD"] = { "<cmd>Bdelete!<cr>", desc = "Delete unsaved" },

      -- Bufferline
      -- Close/pick buffers
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and close buffer" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick and jump to buffer" },
      ["<leader>b["] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffers" },
      ["<leader>b]"] = { "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffers" },
      -- Navigate buffers
      ["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
      ["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" },
      ["<A-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
      ["<A-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },
      ["<leader>bn"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
      ["<leader>bp"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" },
      ["<leader>b>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
      ["<leader>b<"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },

      -- Telescope
      ["<leader>,"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" },
      ["<leader>bb"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" },

      --- FILE ---
      --
      -- File Standalone Keybindings
      ["<leader>fa"] = { "ggVG", desc = "Select all" },
      ["<leader>fi"] = { "gg=G", desc = "Indent all" },
      ["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" },
      ["<leader>fp"] = { "1<C-g>", desc = "Show full path" },
      ["<leader>fs"] = { "<cmd>w<cr>", desc = "Save" },
      ["<leader>ft"] = { "<cmd>%s/\\s\\+$//e | noh<cr>", desc = "Remove trailing whitespaces" },
      ["<leader>fS"] = { "<cmd>SudaWrite<cr>", desc = "Save as root" },
      ["<leader>fu"] = {
        function()
          local supported_configs = { astronvim.install.home, astronvim.install.config }
          local module = "user.init"
          for _, config_path in ipairs(supported_configs) do
            local user_config_path = config_path .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
            if vim.fn.filereadable(user_config_path) == 1 then return vim.cmd("e " .. user_config_path) end
          end
          return astronvim.notify("No user configuration file available at supported paths!", "error")
        end,
        desc = "Open user configuration"
      },

      -- Bufdelete
      ["<leader>fc"] = { "<cmd>Bdelete<cr>", desc = "Close" },
      ["<leader>fC"] = { "<cmd>Bdelete!<cr>", desc = "Close unsaved" },

      -- Telescope
      ["<leader>fb"] = { function() require("telescope").extensions.file_browser.file_browser() end,
        desc = "File browser" },
      ["<leader>fd"] = { "<cmd>Telescope find_files cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>",
        desc = "Find files in CWD" },
      ["<leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "Recently opened files" },

      --- LSP ---
      --
      ["<leader>ld"] = { function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
        desc = "Show document diagnostics" },
      ["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Show workspace diagnostics" },
      ["<leader>le"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Show definition" },
      ["<leader>lR"] = { function() require("telescope.builtin").lsp_references() end, desc = "Show all references" },
      ["<leader>lw"] = { function() require("telescope.builtin").lsp_workspace_symbols() end,
        desc = "Show workspace symbols" },
      ["<leader>ls"] = {
        function()
          local aerial_avail, _ = pcall(require, "aerial")
          if aerial_avail then
            require("telescope").extensions.aerial.aerial()
          else
            require("telescope.builtin").lsp_document_symbols()
          end
        end,
        desc = "Show document symbols"
      },

      --- SEARCH ---
      --
      ["<leader>sp"] = { function() require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown()) end,
        desc = "Search projects" }
    },
    i = {
      -- Move line up and down in insert mode
      ["<A-j>"] = { "<Esc><cmd>m .+1<cr>==gi", desc = "Move line down" },
      ["<A-k>"] = { "<Esc><cmd>m .-2<cr>==gi", desc = "Move line up" },

      -- Save File
      ["<C-s>"] = { "<Esc><cmd>w<cr>", desc = "Save file" },

      -- ToggleTerm
      ["<C-\\>"] = { "<Esc><cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    t = {
      -- ToggleTerm
      ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
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
        config = function() require "user.plugins.heirline" end,
      },

      -- Install and setup user plugins
      --
      -- Theme
      ["catppuccin/nvim"] = {
       as = "catppuccin",
       config = function() require("catppuccin").setup() end
      },

      -- Project management
      ["ahmedkhalf/project.nvim"] = {
        after = "telescope.nvim",
        config = function()
          require("project_nvim").setup()
          require('telescope').load_extension('projects')
        end
      },

      -- Remember last position in a file
      ["ethanholz/nvim-lastplace"] = {
        config = function() require "user.plugins.lastplace" end
      },

      -- Write read-only files with sudo
      ["lambdalisue/suda.vim"] = {}
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "python", "c", "cpp", "haskell", "bash" }, -- automatically install these treesitters
    },

    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = {
      ensure_installed = { "sumneko_lua" },
    },

    toggleterm = {
      highlights = {
        Normal = {
          guibg = "Normal",
        },
        NormalFloat = {
          link = "NormalFloat"
        },
        FloatBorder = {
          link = "FloatBorder"
        },
      },
      shell = "fish", -- set toggleterm shell
    },

    bufferline = {
      options = {
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Title", padding = 1 },
          { filetype = "Outline", text = "Symbols Outline", highlight = "Title", padding = 1 },
        },
        show_duplicate_prefix = false,
      },
      -- highlights = require("catppuccin.groups.integrations.bufferline").get()
    },

    lspkind = {
      symbol_map = {
        Array = "",
        Boolean = "蘒",
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Key = "",
        Keyword = "",
        Method = "",
        Module = "",
        Namespace = "",
        Null = "ﳠ",
        Number = "",
        Object = "",
        Operator = "",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
      }
    },

    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          visible = true -- show hidden/ignored files with different color
        }
      }
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  icons = {
    ActiveLSP1 = "",
    BarBold = "┃",
    Change = "",
    EvilIcon = "",
    FileModified1 = "",
    GitBranch = "",
    GitBranch1 = "",
    Mode = "",
  },

  -- This function is run last
  -- good place to configure augroups/autocommands and custom filetypes
  polish = function()
    -- Neovide settings
    if vim.g.neovide then
      vim.cmd [[
        set guifont=JetBrainsMono\ Nerd\ Font:h11
        let g:neovide_scroll_animation_length = 0
        let g:neovide_hide_mouse_when_typing = v:true
        let g:neovide_refresh_rate = 120
        let g:neovide_cursor_animation_length=0.01
      ]]
    end

    -- Create directory recursively on file save
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Automatically create directory if it doesn't exist on file save",
      pattern = "*",
      callback = function()
        vim.cmd "call mkdir(expand(\"<afile>:p:h\"), \"p\")"
      end
    })
  end,
}

return config
