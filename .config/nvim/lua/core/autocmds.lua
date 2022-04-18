local M = {}

local utils = require "core.utils"

local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

-- Automatically run PackerCompile after new plugins install
augroup("packer_user_config", {})
cmd("BufWritePost", {
  desc = "Auto Compile plugins.lua file",
  group = "packer_user_config",
  command = "source <afile> | PackerCompile",
  pattern = "plugins.lua",
})

-- Automatically run PackerSync on plugins.lua file save
augroup("packer_conf", {})
cmd("BufWritePost", {
  desc = "Sync packer after modifying plugins.lua",
  group = "packer_conf",
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

-- Disable cursorline on losing file focus
augroup("cursor_off", {})
cmd("WinLeave", {
  desc = "No cursorline",
  group = "cursor_off",
  command = "set nocursorline",
})
cmd("WinEnter", {
  desc = "Reenable cursorline",
  group = "cursor_off",
  command = "set cursorline",
})

-- Disable tabline, statusline and cursorline in dashboard buffer
if utils.is_available "dashboard-nvim" then
  augroup("dashboard_settings", {})
  if utils.is_available "bufferline.nvim" then
    cmd("FileType", {
      desc = "Disable tabline for dashboard",
      group = "dashboard_settings",
      pattern = "dashboard",
      command = "set showtabline=0",
    })
    -- cmd("BufWinLeave", {
    --   desc = "Reenable tabline when leaving dashboard",
    --   group = "dashboard_settings",
    --   pattern = "<buffer>",
    --   command = "set showtabline=2",
    -- })
    cmd("BufEnter", {
      desc = "Reenable tabline when leaving dashboard",
      group = "dashboard_settings",
      pattern = "*",
      command = "set showtabline=2",
    })
  end
  cmd("FileType", {
    desc = "Disable statusline for dashboard",
    group = "dashboard_settings",
    pattern = "dashboard",
    command = "set laststatus=0",
  })
  cmd("BufWinLeave", {
    desc = "Reenable statusline when leaving dashboard",
    group = "dashboard_settings",
    pattern = "<buffer>",
    command = "set laststatus=3",
  })
  cmd("BufEnter", {
    desc = "No cursorline on dashboard",
    group = "dashboard_settings",
    pattern = "*",
    command = "if &ft is 'dashboard' | set nocursorline | endif",
  })
end

-- Highlight Yank
augroup("highlight_yank", {})
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

-- Fix lualine not loading in certain cases
if utils.is_available "lualine.nvim" then
  cmd("BufEnter", {
    desc = "Load lualine in sessions and in files opened with e[dit] command",
    pattern = "*",
    command = "lua require'lualine'.setup()",
  })
end

-- Close non-essential splits(help, references, etc.)
cmd("FileType", {
  desc = "Close non-essential splits with 'q'",
  pattern = "qf,help,man",
  command = "nnoremap <silent> <buffer> q :close<CR>",
})

-- Update AstroVim
create_command("AstroUpdate", require("core.utils").update, {})

return M
