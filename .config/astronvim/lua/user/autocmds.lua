-- Create directory recursively on file save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Automatically create directory if it doesn't exist on file save",
  group = vim.api.nvim_create_augroup("_mkdir", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd "call mkdir(expand(\"<afile>:p:h\"), \"p\")"
  end
})

-- Close following buffers with 'q'
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close the specified buffers with 'q'",
  group = vim.api.nvim_create_augroup("_buffer_mappings", { clear = true }),
  pattern = "qf,help,man",
  command = "nnoremap <silent> <buffer> q :close<CR>",
})
