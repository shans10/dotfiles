local config = {

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- Disable default plugins
      -- ["karb94/neoscroll.nvim"] = { disable = true },
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["windwp/nvim-ts-autotag"] = { disable = true },

      -- Add user plugins
      {
        "lambdalisue/suda.vim",
        config = function()
          vim.g.suda_smart_edit = 1   -- Open readonly files automatically with sudo permissions
        end
      },
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
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end,
    }
  end,

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    --- SET OPTIONS ---
    --
    -- Render tabs/trailing spaces
    vim.opt.listchars:append({ tab = '› ', trail = '•', extends = '#', nbsp = '.' })

    -- Automatically go to next line
    vim.opt.whichwrap:append "<,>[,],h,l"

    -- Set default shell
    -- set.shell = "/usr/bin/fish"         -- Linux
    -- set.shell = "pwsh.exe -NoLogo"      -- Windows(PowerShell)
    -- set.shellcmdflag = "-Command"

    --- SET AUTOCOMMANDS ---
    --
    -- PowerShell configuration for windows
    -- vim.cmd [[
    --   let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    --   set shellquote= shellxquote=
    -- ]]
  end,
}

return config
