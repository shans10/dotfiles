local is_available = doomnvim.is_available
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

-- Highlight URLs
augroup("highlighturl", { clear = true })
cmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc = "URL Highlighting",
  group = "highlighturl",
  pattern = "*",
  callback = function()
    doomnvim.set_url_match()
  end,
})

-- Disable tabline, statusline and cursorline in alpha-dashboard buffer
if is_available "alpha-nvim" then
  augroup("alpha_settings", { clear = true })
  if is_available "bufferline.nvim" then
    cmd("FileType", {
      desc = "Disable tabline for alpha",
      group = "alpha_settings",
      pattern = "alpha",
      callback = function()
        local prev_showtabline = vim.opt.showtabline
        vim.opt.showtabline = 0
        cmd("BufUnload", {
          pattern = "<buffer>",
          callback = function()
            vim.opt.showtabline = prev_showtabline
          end,
        })
      end,
    })
  end
  cmd("FileType", {
    desc = "Disable statusline for alpha",
    group = "alpha_settings",
    pattern = "alpha",
    callback = function()
      local prev_status = vim.opt.laststatus
      vim.opt.laststatus = 0
      cmd("BufUnload", {
        pattern = "<buffer>",
        callback = function()
          vim.opt.laststatus = prev_status
        end,
      })
    end,
  })
  cmd("VimEnter", {
    desc = "Start Alpha when vim is opened with no arguments",
    group = "alpha_settings",
    callback = function()
      -- optimized start check from https://github.com/goolord/alpha-nvim
      local alpha_avail, alpha = pcall(require, "alpha")
      if alpha_avail then
        local should_skip = false
        if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
          should_skip = true
        else
          for _, arg in pairs(vim.v.argv) do
            if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
              should_skip = true
              break
            end
          end
        end
        if not should_skip then
          alpha.start(true)
        end
      end
    end,
  })
end

-- Reload feline on changing colorscheme
if is_available "feline.nvim" then
  augroup("feline_setup", { clear = true })
  cmd("ColorScheme", {
    desc = "Reload feline on colorscheme change",
    group = "feline_setup",
    callback = function()
      require("configs.feline").config()
    end,
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
if is_available "nvim-tree.lua" then
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

-- Create a command to update DoomVim
create_command("DoomUpdate", doomnvim.update, { desc = "Update DoomNvim" })

-- Create a command to toggle URL highlight
create_command("ToggleHighlightURL", doomnvim.toggle_url_match, { desc = "Toggle URL Highlights" })
