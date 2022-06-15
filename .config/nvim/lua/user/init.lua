local config = {

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
