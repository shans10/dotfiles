return {
  -- Disable/reconfigure default plugins
  ["p00f/nvim-ts-rainbow"] = { disable = true },
  ["windwp/nvim-ts-autotag"] = { disable = true },

  -- Statusline
  -- ["rebelot/heirline.nvim"] = {
  --     event = "VimEnter",
  --     -- config = function() require "user.plugins.heirline.doom" end,
  --     config = function() require "user.plugins.heirline.lunarvim" end,
  --   },

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
      config = function() require "user.plugins.nvim-lastplace" end
    },

    -- Write read-only files with sudo
    ["lambdalisue/suda.vim"] = {}
  }
