return {
  n = {
    ["<leader>ld"] = false, -- disable hover diagnostic keymap
    ["<leader>ll"] = { function() vim.diagnostic.open_float() end, desc = "Show line diagnostics" },
    ["gh"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" }
  }
}
