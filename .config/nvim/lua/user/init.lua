local config = {

  -- Set colorscheme
  colorscheme = "default_theme",
  -- colorscheme = "onedarker",

  -- Default theme configuration
  -- default_theme = {
  --   diagnostics_style = "none",
    -- Modify the color table
    -- colors = {
    --   fg = "#abb2bf",
    -- },
    -- Modify the highlight groups
    -- highlights = function(highlights)
    --   local C = require "default_theme.colors"
    --
    --   highlights.Normal = { fg = C.fg, bg = C.bg }
    --   return highlights
    -- end,
  -- },

  -- Disable default plugins
  enabled = {
    bufferline = true,
    nvim_tree = true,
    lualine = true,
    lspsaga = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      { "farmergreg/vim-lastplace" },
      { "lunarvim/onedarker.nvim" },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- Even if you are pleased with the defaults,
            -- please note that setup {} must be called for the plugin to start.
          }
        end
      },
      {
        "ggandor/lightspeed.nvim",
        config = function()
          require'lightspeed'.setup {
            ignore_case = true,
            -- Leaving the appropriate list empty effectively disables "smart" mode,
            -- and forces auto-jump to be on or off.
            -- safe_labels = {"s", "f", "n",
            --                "u", "t",
            --                "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z"},

            labels = {"s", "f", "n",
                      "j", "k", "l", "o", "d", "w", "e", "h", "m", "v", "g",
                      "u", "t",
                      "c", ".", "z",
                      "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z"},
            --- f/t ---
            limit_ft_matches = 5,
            repeat_ft_with_target_char = false,
            -- EasyMotion/Hop-style config
            jump_to_unique_chars = false,
            safe_labels = {}
          }
        end
      }
      -- { "lambdalisue/suda.vim" },
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "go", "c", "java" },
    },
    packer = {
      compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    },
  },

  -- Add paths for including more VS Code style snippets in luasnip
  luasnip = {
    vscode_snippet_paths = {},
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings to the normal mode <leader> mappings
    register_n_leader = {
      -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   server:setup(opts)
    -- end

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
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
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = false,
  },

  -- null-ls configuration
  ["null-ls"] = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      debug = false,
      sources = {
        -- Set a formatter
        formatting.rufo,
        -- Set a linter
        diagnostics.rubocop,
      },
      -- NOTE: You can remove this on attach function to disable format on save
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
        end
      end,
    }
  end,

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    local set = vim.opt

    --- SET OPTIONS ---
    --
    -- Enable relativenumber
    set.relativenumber = true

    -- Automatically go to next line
    set.whichwrap:append "<,>,[,],h,l"

    -- Render tabs/spaces
    set.list = true
    set.listchars:append({ tab = '› ', trail = '•', extends = '#', nbsp = '.' })

    -- Set powershell as default shell in windows
    set.shell = "pwsh.exe -NoLogo"
    set.shellcmdflag = "-Command"

    --- SET KEYBINDINGS ---
    --
    -- Force write with Ctrl+S
    map("n", "<C-s>", ":w!<CR>", opts)

    --- SET AUTOCOMMANDS ---
    --
    -- Automatically run PackerSync on plugins.lua file change
    vim.cmd [[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end
    ]]

    -- Disable tabline in dashboard buffer
    vim.cmd [[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]

    -- Highlight yank
    vim.cmd [[
      augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=300})
      augroup END
    ]]

    -- Autoremove trailing whitespaces on save
    vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

    -- Powershell configuration for windows
    vim.cmd [[
      let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
      let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
      set shellquote= shellxquote=
    ]]

    -- Change numbering between relative/absolute in normal/insert modes
    -- vim.cmd [[
    --   augroup numbertoggle
    --     autocmd!
    --     autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    --     autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    --   augroup END
    -- ]]

    -- Change nvim-tree root to current buffer root
    -- vim.cmd [[autocmd BufEnter * silent! lcd %:p:h]]
  end,
}

-- Vim suda smart edit
-- vim.g.suda_smart_edit = 1

return config
