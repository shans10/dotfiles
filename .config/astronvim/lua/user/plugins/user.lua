return {
  "lambdalisue/suda.vim",
  event = "User AstroFile",
  enabled = function() return not vim.g.win32 end
}
