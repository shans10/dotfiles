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
end

-- Navigate buffers
if utils.is_available "bufferline.nvim" then
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer tab" })
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer tab" })
  map("n", "}", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer tab right" })
  map("n", "{", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer tab left" })
else
  map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
  map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
end

-- Move lines up and down in normal mode
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration of current symbol" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current symbol" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation of current symbol" })
map("n", "gr", vim.lsp.buf.references, { desc = "References of current symbol" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "gk", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "gj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover symbol details" })
map("n", "gh", vim.lsp.buf.hover, { desc = "Hover symbol details" })
map("n", "gR", vim.lsp.buf.rename, { desc = "Rename current symbol" })

-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>", { desc = "Force write" })

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>", { desc = "Force quit" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlightwith esc" })

-- ToggleTerm
if utils.is_available "nvim-toggleterm.lua" then
  map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
end

-- SessionManager
if utils.is_available "neovim-session-manager" then
  map("n", "<leader>rl", "<cmd>SessionManage load_last_session<CR>", { desc = "Load last session" })
end

-- Normal Leader Mappings --
-- NOTICE: if changed, update configs/which-key-register.lua
-- Allows easy user modifications when just overriding which-key
-- But allows bindings to work for users without which-key
if not utils.is_available "which-key.nvim" then
  -- Standard Operations
  map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
  map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
  map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
  map("n", "<leader>.", "<cmd>cd %:p:h<CR>", { desc = "Change CWD to focused file" })

  -- Packer
  map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer compile" })
  map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer install" })
  map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer sync" })
  map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer status" })
  map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer update" })

  -- LSP Standalone Keybindings
  map("n", "<leader>lf", "vim.lsp.buf.formatting_sync", { desc = "Format code" })
  map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP information" })
  map("n", "<leader>lI", "<cmd>LspInstallInfo<CR>", { desc = "LSP installer" })
  map("n", "<leader>la", "vim.lsp.buf.code_action", { desc = "LSP code action" })
  map("n", "<leader>lR", "vim.lsp.buf.rename", { desc = "Rename current symbol" })
  map("n", "<leader>ld", "vim.diagnostic.open_float", { desc = "Hover diagnostics" })

  -- File Standalone Keybindings
  map("n", "<leader>fi", "gg=G", { desc = "Indent whole file" })
  map("n", "<leader>fp", "1<C-g>", { desc = "Show full file path" })
  map("n", "<leader>fr", "<cmd>e<CR>", { desc = "Refresh file" })
  map("n", "<leader>fR", "<cmd>e!<CR>", { desc = "Refresh file with unsaved changes" })
  map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save file" })
  map("n", "<leader>fS", "ggVG", { desc = "Select all" })

  -- Buffer Standalone Keybindings
  map("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" })
  map("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" })

  -- VimBbye
  if utils.is_available "vim-bbye" then
    map("n", "<leader>c", "<cmd>Bdelete!<CR>", { desc = "Delete buffer" })

    -- Buffer
    map("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Delete buffer" })
    map("n", "<leader>bD", "<cmd>Bdelete!<CR>", { desc = "Delete buffer with unsaved changes" })

    -- File
    map("n", "<leader>fc", "<cmd>Bdelete<CR>", { desc = "Close file" })
    map("n", "<leader>fC", "<cmd>Bdelete!<CR>", { desc = "Close file with unsaved changes" })
  end

  -- NvimTree
  if utils.is_available "nvim-tree.lua" then
    map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
  end

  -- Dashboard
  if utils.is_available "dashboard-nvim" then
    map("n", "<leader>d", "<cmd>Dashboard<CR>", { desc = "Dashboard" })
    map("n", "<leader>m", "<cmd>DashboardJumpMarks<CR>", { desc = "Bookmarks" })

    -- File
    map("n", "<leader>fn", "<cmd>DashboardNewFile<CR>", { desc = "New file" })
  end

  -- Bufferline
  if utils.is_available "bufferline.nvim" then
    map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick and close buffer" })
    map("n", "<leader>bj", "<cmd>BufferLinePick<CR>", { desc = "Pick and jump to buffer" })
    map("n", "<leader>bN", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer tab right" })
    map("n", "<leader>bP", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer tab left" })
  end

  -- Comment
  if utils.is_available "Comment.nvim" then
    map("n", "<leader>/", function()
      require("Comment.api").toggle_current_linewise()
    end, { desc = "Toggle comment line" })
  end

  -- SymbolsOutline
  if utils.is_available "symbols-outline.nvim" then
    map("n", "<leader>lS", "<cmd>SymbolsOutline<CR>", { desc = "Symbols outline" })
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
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm float" })
    map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "ToggleTerm horizontal split" })
    map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "ToggleTerm vertical split" })
  end

  -- SessionManager
  if utils.is_available "neovim-session-manager" then
    -- Session
    map("n", "<leader>Sd", "<cmd>SessionManage delete_session<CR>", { desc = "Delete session from list" })
    map("n", "<leader>Sl", "<cmd>SessionManage load_last_session<CR>", { desc = "Load last session" })
    map("n", "<leader>SL", "<cmd>SessionManage load_session<CR>", { desc = "Load session from list" })
    map("n", "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", { desc = "Save current session" })

    -- Search
    map("n", "<leader>ss", "<cmd>SessionManage load_session<CR>", { desc = "Load last session" })
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
    map("n", "<leader>fd", "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<CR>", { desc = "Search files in CWD" })
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
      require("telescope.builtin").lsp_document_symbols()
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
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })

-- Save File
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

--- VISUAL MODE ---
--
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Unindent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move text down" })
map("v", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move text up" })

-- Comment
if utils.is_available "Comment.nvim" then
  map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", { desc = "Toggle comment line" })
end

--- VISUAL BLOCK MODE ---
--
-- Move text up and down
map("x", "J", "<cmd>move '>+1<CR>gv-gv", { desc = "Move text down" })
map("x", "K", "<cmd>move '<-2<CR>gv-gv", { desc = "Move text up" })
map("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", { desc = "Move text down" })
map("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", { desc = "Move text up" })

-- disable Ex mode:
map("n", "Q", "<Nop>")

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

augroup("TermMappings", {})
cmd("TermOpen", {
  desc = "Set terminal keymaps",
  group = "TermMappings",
  callback = _G.set_terminal_keymaps,
})

return M
