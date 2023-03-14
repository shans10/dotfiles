-- Create directory recursively on file save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Automatically create directory if it doesn't exist on file save",
    group = vim.api.nvim_create_augroup("_mkdir", { clear = true }),
    pattern = "*",
    callback = function()
      vim.cmd "call mkdir(expand(\"<afile>:p:h\"), \"p\")"
    end
})

-- Change line numbering system based on mode
vim.api.nvim_create_augroup("relative_number_switch", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Switch to absolute line numbering when entering Insert mode",
    group = "relative_number_switch",
    pattern = "*",
    callback = function()
      if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.w.adaptive_relative_number_state = true
      end
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    desc = "Switch to relative line numbering when leaving Insert mode",
    group = "relative_number_switch",
    pattern = "*",
    callback = function()
      if vim.w.adaptive_relative_number_state then
        vim.wo.relativenumber = true
        vim.w.adaptive_relative_number_state = false
      end
    end,
})
