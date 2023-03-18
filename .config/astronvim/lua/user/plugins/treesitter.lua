return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "mrjones2014/nvim-ts-rainbow",
  },
  opts = {
    highlight = { disable = { "help" } },
    indent = { enable = true, disable = { "python" } },
    matchup = { enable = true },
    rainbow = { enable = true },
    ensure_installed = {
      "lua",
      "python",
    }
  },
}
