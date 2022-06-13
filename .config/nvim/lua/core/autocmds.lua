local M = {}

local utils = require "core.utils"

local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

-- Automatically run PackerSync on plugins.lua file save
augroup("packer_conf", { clear = true })
cmd("BufWritePost", {
  desc = "Sync packer after modifying plugins.lua",
  group = "packer_conf",
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

-- Disable cursorline on losing file focus
augroup("cursor_off", { clear = true })
cmd("BufLeave", {
  desc = "No cursorline",
  group = "cursor_off",
  callback = function()
    vim.opt.cursorline = false
  end,
})
cmd({ "BufEnter", "FileType" }, {
  desc = "Reenable cursorline",
  group = "cursor_off",
  callback = function()
    vim.opt.cursorline = not vim.tbl_contains({ "alpha", "TelescopePrompt" }, vim.bo.filetype)
  end,
})

-- Highlight URLs
augroup("highlighturl", { clear = true })
cmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc = "URL Highlighting",
  group = "highlighturl",
  pattern = "*",
  callback = require("core.utils").set_url_match,
})

-- Disable tabline, statusline and cursorline in alpha dashboard buffer
if utils.is_available "alpha-nvim" then
  augroup("alpha_settings", { clear = true })
  if utils.is_available "bufferline.nvim" then
    cmd("FileType", {
      desc = "Disable tabline for alpha",
      group = "alpha_settings",
      pattern = "alpha",
      command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
    })
  end
  cmd("FileType", {
    desc = "Disable statusline for alpha",
    group = "alpha_settings",
    pattern = "alpha",
    command = "set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3",
  })
end

-- Highlight Yank
augroup("highlight_yank", { clear = true })
cmd("TextYankPost", {
  desc = "Highlight copied text for visual confirmation",
  group = "highlight_yank",
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank({higroup=\"Search\", timeout=300})",
})

-- Remove Trailing Whitespaces
cmd("BufWritePre", {
  desc = "Autoremove trailing whitespaces on file save",
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- AutoClose NvimTree
if utils.is_available "nvim-tree.lua" then
  cmd("BufEnter", {
    desc = "Automatically close the tab/vim when nvim-tree is the last window in the tab",
    pattern = "*",
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  })
end

-- Close non-essential splits(help, references, etc.)
cmd("FileType", {
  desc = "Close non-essential splits with 'q'",
  pattern = "qf,help,man",
  command = "nnoremap <silent> <buffer> q :close<CR>",
})

-- Create a command to update AstroVim
create_command("AstroUpdate", require("core.utils").update, { desc = "Update AstroNvim" })

-- Create a command to toggle URL highlight
create_command("ToggleHighlightURL", require("core.utils").toggle_url_match, { desc = "Toggle URL Highlights" })

return M
