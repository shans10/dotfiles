local M = {}

local utils = require "core.utils"

local map = vim.keymap.set
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

--- NORMAL MODE ---
--
if utils.is_available "smart-splits.nvim" then
  -- Better window navigation
  map("n", "<C-h>", function()
    require("smart-splits").move_cursor_left()
  end, { desc = "Move to left split" })
  map("n", "<C-j>", function()
    require("smart-splits").move_cursor_down()
  end, { desc = "Move to below split" })
  map("n", "<C-k>", function()
    require("smart-splits").move_cursor_up()
  end, { desc = "Move to above split" })
  map("n", "<C-l>", function()
    require("smart-splits").move_cursor_right()
  end, { desc = "Move to right split" })

  -- Resize with arrows
  map("n", "<C-Up>", function()
    require("smart-splits").resize_up()
  end, { desc = "Resize split up" })
  map("n", "<C-Down>", function()
    require("smart-splits").resize_down()
  end, { desc = "Resize split down" })
  map("n", "<C-Left>", function()
    require("smart-splits").resize_left()
  end, { desc = "Resize split left" })
  map("n", "<C-Right>", function()
    require("smart-splits").resize_right()
  end, { desc = "Resize split right" })
else
  map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
  map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
  map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
  map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
  map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
  map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
end

-- Navigate buffers
if utils.is_available "bufferline.nvim" then
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
  map("n", ">b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
  map("n", "<b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
else
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
end

-- Move lines up and down in normal mode
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- LSP
map("n", "K", vim.lsp.buf.hover, { desc = "Hover symbol details" })

-- ForceWrite
map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlightwith esc" })

-- ToggleTerm
if utils.is_available "nvim-toggleterm.lua" then
  map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
end

-- Disable Ex mode:
map("n", "Q", "<Nop>")

-- Load user config
map("n", "<leader>uc", "<cmd>exe \"edit\" stdpath(\"config\").\"/lua/user/init.lua\"<cr>", { desc = "Load user configuration" })

-- Normal Leader Mappings --
-- NOTICE: if changed, update configs/which-key-register.lua
-- Allows easy user modifications when just overriding which-key
-- But allows bindings to work for users without which-key
if not utils.is_available "which-key.nvim" then
  -- Standard Operations
  map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
  map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
  map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
  map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Change CWD to focused file" })
  map("n", "<leader>U", require("core.utils").toggle_url_match, { desc = "Toggle URL Highlights" })

  -- Packer
  map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer compile" })
  map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer install" })
  map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer sync" })
  map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer status" })
  map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer update" })

  -- LSP Standalone Keybindings
  map("n", "<leader>lf", "vim.lsp.buf.formatting_sync", { desc = "Format code" })
  map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
  map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })
  map("n", "<leader>la", "vim.lsp.buf.code_action", { desc = "LSP code action" })
  map("n", "<leader>lR", "vim.lsp.buf.rename", { desc = "Rename current symbol" })
  map("n", "<leader>ld", "vim.diagnostic.open_float", { desc = "Hover diagnostics" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration of current symbol" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current symbol" })
  map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation of current symbol" })
  map("n", "gr", vim.lsp.buf.references, { desc = "References of current symbol" })
  map("n", "gl", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  map("n", "gk", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  map("n", "gj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  map("n", "gh", vim.lsp.buf.hover, { desc = "Hover symbol details" })
  map("n", "gR", vim.lsp.buf.rename, { desc = "Rename current symbol" })
  map("n", "gx", utils.url_opener_cmd(), { desc = "Open the file under cursor with system app" })

  -- File Standalone Keybindings
  map("n", "<leader>fi", "gg=G", { desc = "Indent whole file" })
  map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
  map("n", "<leader>fp", "1<C-g>", { desc = "Show full file path" })
  map("n", "<leader>fr", "<cmd>e<cr>", { desc = "Refresh file" })
  map("n", "<leader>fR", "<cmd>e!<cr>", { desc = "Refresh file with unsaved changes" })
  map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
  map("n", "<leader>fS", "ggVG", { desc = "Select all" })

  -- Buffer Standalone Keybindings
  map("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next buffer" })
  map("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous buffer" })

  -- Bufdelete
  if utils.is_available "bufdelete.nvim" then
    map("n", "<leader>c", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })

    -- Buffer
    map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete buffer" })
    map("n", "<leader>bD", "<cmd>Bdelete!<cr>", { desc = "Delete buffer with unsaved changes" })

    -- File
    map("n", "<leader>fc", "<cmd>Bdelete<cr>", { desc = "Close file" })
    map("n", "<leader>fC", "<cmd>Bdelete!<cr>", { desc = "Close file with unsaved changes" })

  -- Standalone(If bufdelete is not installed)
  else
    map("n", "<leader>c", "<cmd>bdelete!<cr>", { desc = "Close buffer" })

    -- Buffer
    map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
    map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer with unsaved changes" })

    -- File
    map("n", "<leader>fc", "<cmd>bdelete<cr>", { desc = "Close file" })
    map("n", "<leader>fC", "<cmd>bdelete!<cr>", { desc = "Close file with unsaved changes" })
  end

  -- NvimTree
  if utils.is_available "nvim-tree.lua" then
    map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })
    map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus NvimTree" })
  end

  -- Alpha Dashboard
  if utils.is_available "alpha-nvim" then
    map("n", "<leader>d", "<cmd>Alpha<cr>", { desc = "Alpha Dashboard" })
  end

  -- Bufferline
  if utils.is_available "bufferline.nvim" then
    map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick and close buffer" })
    map("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "Pick and jump to buffer" })
    map("n", "<leader>bN", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
    map("n", "<leader>bP", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
  end

  -- Comment
  if utils.is_available "Comment.nvim" then
    map("n", "<leader>/", function()
      require("Comment.api").toggle_current_linewise()
    end, { desc = "Toggle comment line" })
  end

  -- Aerial
  if utils.is_available "aerial.nvim" then
    map("n", "<leader>lS", "<cmd>AerialToggle<cr>", { desc = "Symbols outline" })
  end

  -- ToggleTerm
  if utils.is_available "nvim-toggleterm.lua" then
    -- Git
    map("n", "<leader>gg", function()
      utils.toggle_term_cmd "lazygit"
    end, { desc = "ToggleTerm lazygit" })

    -- Terminal
    map("n", "<leader>tl", function()
      utils.toggle_term_cmd "lazygit"
    end, { desc = "ToggleTerm lazygit" })
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
    map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
    map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
  end

  -- SessionManager
  if utils.is_available "neovim-session-manager" then
    -- Session
    map("n", "<leader>Sd", "<cmd>SessionManager! delete_session<cr>", { desc = "Delete session from list" })
    map("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", { desc = "Load last session" })
    map("n", "<leader>SL", "<cmd>SessionManager! load_session<cr>", { desc = "Load session from list" })
    map("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", { desc = "Save current session" })

    -- Search
    map("n", "<leader>ss", "<cmd>SessionManager! load_session<cr>", { desc = "Search sessions" })
  end

  -- GitSigns
  if utils.is_available "gitsigns.nvim" then
    map("n", "<leader>gj", function()
      require("gitsigns").next_hunk()
    end, { desc = "Next git hunk" })
    map("n", "<leader>gk", function()
      require("gitsigns").prev_hunk()
    end, { desc = "Previous git hunk" })
    map("n", "<leader>gl", function()
      require("gitsigns").blame_line()
    end, { desc = "View git blame" })
    map("n", "<leader>gp", function()
      require("gitsigns").preview_hunk()
    end, { desc = "Preview git hunk" })
    map("n", "<leader>gh", function()
      require("gitsigns").reset_hunk()
    end, { desc = "Reset git hunk" })
    map("n", "<leader>gr", function()
      require("gitsigns").reset_buffer()
    end, { desc = "Reset git buffer" })
    map("n", "<leader>gs", function()
      require("gitsigns").stage_hunk()
    end, { desc = "Stage git hunk" })
    map("n", "<leader>gu", function()
      require("gitsigns").undo_stage_hunk()
    end, { desc = "Unstage git hunk" })
    map("n", "<leader>gd", function()
      require("gitsigns").diffthis()
    end, { desc = "View git diff" })
  end

  -- Telescope
  if utils.is_available "telescope.nvim" then
    -- Bookmarks
    map("n", "<leader>m", function()
      require("telescope.builtin").marks()
    end, { desc = "Show Bookmarks" })

    -- Buffer
    map("n", "<leader>bl", function()
      require("telescope.builtin").buffers()
    end, { desc = "List buffers" })

    -- Git
    map("n", "<leader>gb", function()
      require("telescope.builtin").git_branches()
    end, { desc = "Show git branches" })
    map("n", "<leader>gc", function()
      require("telescope.builtin").git_commits()
    end, { desc = "Show git commits" })
    map("n", "<leader>gt", function()
      require("telescope.builtin").git_status()
    end, { desc = "Show git status" })

    -- File
    map("n", "<leader>fd", "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>", { desc = "Search files in CWD" })
    map("n", "<leader>ff", function()
      require("telescope.builtin").find_files()
    end, { desc = "Search files" })
    map("n", "<leader>fF", function()
      require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
    end, { desc = "Search files including hidden" })
    map("n", "<leader>fo", function()
      require("telescope.builtin").oldfiles()
    end, { desc = "Show recently opened files" })

    -- LSP
    map("n", "<leader>lD", function()
      require("telescope.builtin").diagnostics()
    end, { desc = "Show all diagnostics" })
    map("n", "<leader>le", function()
      require("telescope.builtin").lsp_definitions()
    end, { desc = "Show definitions" })
    map("n", "<leader>lr", function()
      require("telescope.builtin").lsp_references()
    end, { desc = "Show all references" })
    map("n", "<leader>ls", function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end, { desc = "Search document symbols" })

    -- Search
    map("n", "<leader>sc", function()
      require("telescope.builtin").commands()
    end, { desc = "Search commands" })
    map("n", "<leader>sh", function()
      require("telescope.builtin").help_tags()
    end, { desc = "Search help" })
    map("n", "<leader>sk", function()
      require("telescope.builtin").keymaps()
    end, { desc = "Search keymaps" })
    map("n", "<leader>sm", function()
      require("telescope.builtin").man_pages()
    end, { desc = "Search man-pages" })
    map("n", "<leader>sn", function()
      require("telescope").extensions.notify.notify()
    end, { desc = "Search notifications" })
    map("n", "<leader>sr", function()
      require("telescope.builtin").registers()
    end, { desc = "Search registers" })
    map("n", "<leader>st", function()
      require("telescope.builtin").live_grep()
    end, { desc = "Search text" })
    -- Project
    if utils.is_available "project.nvim" then
      -- Standalone
      map("n", "<leader>P", function()
        require("telescope").extensions.projects.projects()
      end, { desc = "Search projects" })

      -- Search
      map("n", "<leader>sp", function()
        require("telescope").extensions.projects.projects()
      end, { desc = "Search projects" })
    end
  end
end

--- INSERT MODE ---
--
-- Move line up and down in insert mode
map("i", "<A-j>", "<Esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })

-- Save File
map("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file" })

--- VISUAL MODE ---
--
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Unindent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move text down" })
map("v", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move text up" })

-- Comment
if utils.is_available "Comment.nvim" then
  map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", { desc = "Toggle comment line" })
end

--- TERMINAL MODE ---
--
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\>]], { desc = "Terminal normal mode" })
  vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\>]], { desc = "Terminal normal mode" })
  vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-W>h]], { desc = "Terminal left window navigation" })
  vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-W>j]], { desc = "Terminal down window navigation" })
  vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-W>k]], { desc = "Terminal up window navigation" })
  vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-W>l]], { desc = "Terminal right window naviation" })
end

augroup("TermMappings", { clear = true })
cmd("TermOpen", {
  desc = "Set terminal keymaps",
  group = "TermMappings",
  callback = _G.set_terminal_keymaps,
})

return M
