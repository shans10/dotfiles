local config = {

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Disable default plugins
  enabled = {
    bufferline = true,
    nvim_tree = true,
    lualine = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = false,
    ts_rainbow = false,
    ts_autotag = false,
    lastplace = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- {
      --   "lambdalisue/suda.vim",
      --   config = function()
      --     vim.g.suda_smart_edit = 1   -- Open readonly files automatically with sudo permissions
      --   end
      -- },
    },

    -- All other entries override the setup() call for default plugins
    treesitter = {
      ensure_installed = { "lua", "go", "c", "java" },
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

    -- Render tabs/trailing spaces
    set.list = true
    set.listchars:append({ tab = '› ', trail = '•', extends = '#', nbsp = '.' })

    -- Set default shell
    -- set.shell = "/usr/bin/fish"         -- Linux
    -- set.shell = "pwsh.exe -NoLogo"      -- Windows(PowerShell)
    -- set.shellcmdflag = "-Command"

    --- SET KEYBINDINGS ---
    --
    -- Reload last sesssion
    map("n", "<leader>rl", "<cmd>SessionManage load_last_session<CR>", opts)

    --- SET AUTOCOMMANDS ---
    --
    -- PowerShell configuration for windows
    -- vim.cmd [[
    --   let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   set shellquote= shellxquote=
    -- ]]

    -- Open explorer without focus on session load
    -- vim.cmd [[autocmd SessionLoadPost * lua require"nvim-tree".toggle(false, true)]]
  end,
}

return config
