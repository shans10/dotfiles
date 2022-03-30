local config = {

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      { "farmergreg/vim-lastplace" },
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
          require("lightspeed").setup {
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
      },
      {
        "Shatur/neovim-session-manager",
        config = function()
        require("session_manager").setup {
          autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
        }
      end
      },
      -- { "lambdalisue/suda.vim" },
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "go", "c", "java" },
    },

    telescope = {
      require("telescope").load_extension "projects"
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

    -- Set default shell
    -- set.shell = "/usr/bin/fish"         -- Linux
    -- set.shell = "pwsh.exe -NoLogo"      -- Windows(PowerShell)
    -- set.shellcmdflag = "-Command"

    --- SET KEYBINDINGS ---
    --
    -- Force write with Ctrl+S
    map("n", "<C-s>", ":w!<CR>", opts)

    --- SET AUTOCOMMANDS ---
    -- PowerShell configuration for windows
    -- vim.cmd [[
    --   let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   set shellquote= shellxquote=
    -- ]]
  end,
}

-- Vim suda smart edit
-- vim.g.suda_smart_edit = 1

return config
