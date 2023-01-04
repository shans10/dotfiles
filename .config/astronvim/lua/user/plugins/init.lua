return {
  --- Disable default plugins ---
  --
  -- ["p00f/nvim-ts-rainbow"] = { disable = true }, -- disable bracket pair colors
  ["windwp/nvim-ts-autotag"] = { disable = true }, -- disable autotag based on treesitter
  ["akinsho/bufferline.nvim"] = { disable = true }, -- disable bufferline

  --- Install and setup user plugins ---
  --
  -- Theme
  ["catppuccin/nvim"] = {
    as = "catppuccin",
    module = "catppuccin",
    config = function() require "user.plugins.catppuccin" end
  },

  -- Restore last position in a file when opened
  ["ethanholz/nvim-lastplace"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "nvim-lastplace") end,
    config = function() require "user.plugins.nvim-lastplace" end,
  },

  -- Telescope based file browser
  ["nvim-telescope/telescope-file-browser.nvim"] = {
    after = "telescope.nvim",
    config = function() require "user.plugins.telescope-file-browser" end,
  },

  -- Telescope based project management
  ["nvim-telescope/telescope-project.nvim"] = {
    after = "telescope.nvim",
    config = function() require "user.plugins.telescope-project" end,
  },

  ["fedepujol/move.nvim"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "move.nvim") end,
  },

  -- Write read-only files with sudo
  ["lambdalisue/suda.vim"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "suda.vim") end,
  },

  -- Java lsp configuration
  ["mfussenegger/nvim-jdtls"] = { module = "jdtls" }, -- load jdtls on module
}
