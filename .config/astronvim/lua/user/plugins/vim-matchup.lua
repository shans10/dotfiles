return {
  "andymass/vim-matchup",
  event = "User AstroFile",
  opts = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end
}
