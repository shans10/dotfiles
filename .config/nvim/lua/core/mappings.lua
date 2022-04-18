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
  end)
  map("n", "<C-j>", function()
    require("smart-splits").move_cursor_down()
  end)
  map("n", "<C-k>", function()
    require("smart-splits").move_cursor_up()
  end)
  map("n", "<C-l>", function()
    require("smart-splits").move_cursor_right()
  end)

  -- Resize with arrows
  map("n", "<C-Up>", function()
    require("smart-splits").resize_up()
  end)
  map("n", "<C-Down>", function()
    require("smart-splits").resize_down()
  end)
  map("n", "<C-Left>", function()
    require("smart-splits").resize_left()
  end)
  map("n", "<C-Right>", function()
    require("smart-splits").resize_right()
  end)
end

-- Navigate buffers
if utils.is_available "bufferline.nvim" then
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
  map("n", "}", "<cmd>BufferLineMoveNext<CR>")
  map("n", "{", "<cmd>BufferLineMovePrev<CR>")
else
  map("n", "<S-l>", "<cmd>bnext<CR>")
  map("n", "<S-h>", "<cmd>bprevious<CR>")
end

-- Move lines up and down in normal mode
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")

-- LSP
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current function" })
map("n", "gI", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
map("n", "gl", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "gk", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "gj", vim.diagnostic.goto_next)
map("n", "K", vim.lsp.buf.hover)
map("n", "gh", vim.lsp.buf.hover)

-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>")

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>")

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<CR>")

-- ToggleTerm
if utils.is_available "nvim-toggleterm.lua" then
  map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
end

-- SessionManager
if utils.is_available "neovim-session-manager" then
  map("n", "<leader>rl", "<cmd>SessionManage load_last_session<CR>")
end

-- Normal Leader Mappings --
-- NOTICE: if changed, update configs/which-key-register.lua
-- Allows easy user modifications when just overriding which-key
-- But allows bindings to work for users without which-key
if not utils.is_available "which-key.nvim" then
  -- Standard Operations
  map("n", "<leader>w", "<cmd>w<CR>")
  map("n", "<leader>q", "<cmd>q<CR>")
  map("n", "<leader>h", "<cmd>nohlsearch<CR>")
  map("n", "<leader>.", "<cmd>cd %:p:h<CR>")

  -- Packer
  map("n", "<leader>pc", "<cmd>PackerCompile<CR>")
  map("n", "<leader>pi", "<cmd>PackerInstall<CR>")
  map("n", "<leader>ps", "<cmd>PackerSync<CR>")
  map("n", "<leader>pS", "<cmd>PackerStatus<CR>")
  map("n", "<leader>pu", "<cmd>PackerUpdate<CR>")

  -- LSP Standalone Keybindings
  map("n", "<leader>lf", "vim.lsp.buf.formatting_sync")
  map("n", "<leader>li", "<cmd>LspInfo<CR>")
  map("n", "<leader>lI", "<cmd>LspInstallInfo<CR>")
  map("n", "<leader>la", "vim.lsp.buf.code_action")
  map("n", "<leader>lR", "vim.lsp.buf.rename")
  map("n", "<leader>ld", "vim.diagnostic.open_float")

  -- File Standalone Keybindings
  map("n", "<leader>fi", "gg=G")
  map("n", "<leader>fp", "1<C-g>")
  map("n", "<leader>fr", "<cmd>e<CR>")
  map("n", "<leader>fR", "<cmd>e!<CR>")
  map("n", "<leader>fs", "<cmd>w<CR>")
  map("n", "<leader>fS", "ggVG")

  -- Buffer Standalone Keybindings
  map("n", "<leader>bn", "<cmd>bn<CR>")
  map("n", "<leader>bp", "<cmd>bp<CR>")

  -- VimBbye
  if utils.is_available "vim-bbye" then
    map("n", "<leader>c", "<cmd>Bdelete!<CR>")

    -- Buffer
    map("n", "<leader>bd", "<cmd>Bdelete<CR>")
    map("n", "<leader>bD", "<cmd>Bdelete!<CR>")

    -- File
    map("n", "<leader>fc", "<cmd>Bdelete<CR>")
    map("n", "<leader>fC", "<cmd>Bdelete!<CR>")
  end

  -- NvimTree
  if utils.is_available "nvim-tree.lua" then
    map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>")
  end

  -- Dashboard
  if utils.is_available "dashboard-nvim" then
    map("n", "<leader>d", "<cmd>Dashboard<CR>")
    map("n", "<leader>m", "<cmd>DashboardJumpMarks<CR>")

    -- File
    map("n", "<leader>fn", "<cmd>DashboardNewFile<CR>")
  end

  -- Bufferline
  if utils.is_available "bufferline.nvim" then
    map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>")
    map("n", "<leader>bj", "<cmd>BufferLinePick<CR>")
    map("n", "<leader>bN", "<cmd>BufferLineMoveNext<CR>")
    map("n", "<leader>bP", "<cmd>BufferLineMovePrev<CR>")
  end

  -- Comment
  if utils.is_available "Comment.nvim" then
    map("n", "<leader>/", function()
      require("Comment.api").toggle_current_linewise()
    end)
  end

  -- SymbolsOutline
  if utils.is_available "symbols-outline.nvim" then
    map("n", "<leader>lS", "<cmd>SymbolsOutline<CR>")
  end

  -- ToggleTerm
  if utils.is_available "nvim-toggleterm.lua" then
    -- Git
    map("n", "<leader>gg", function()
      utils.toggle_term_cmd "lazygit"
    end)

    -- Terminal
    map("n", "<leader>tl", function()
      utils.toggle_term_cmd "lazygit"
    end)
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>")
    map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>")
    map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>")
  end

  -- SessionManager
  if utils.is_available "neovim-session-manager" then
    -- Session
    map("n", "<leader>Sd", "<cmd>SessionManage delete_session<CR>")
    map("n", "<leader>Sl", "<cmd>SessionManage load_last_session<CR>")
    map("n", "<leader>SL", "<cmd>SessionManage load_session<CR>")
    map("n", "<leader>Ss", "<cmd>SessionManager save_current_session<CR>")

    -- Search
    map("n", "<leader>ss", "<cmd>SessionManage load_session<CR>")
  end

  -- GitSigns
  if utils.is_available "gitsigns.nvim" then
    map("n", "<leader>gj", function()
      require("gitsigns").next_hunk()
    end)
    map("n", "<leader>gk", function()
      require("gitsigns").prev_hunk()
    end)
    map("n", "<leader>gl", function()
      require("gitsigns").blame_line()
    end)
    map("n", "<leader>gp", function()
      require("gitsigns").preview_hunk()
    end)
    map("n", "<leader>gh", function()
      require("gitsigns").reset_hunk()
    end)
    map("n", "<leader>gr", function()
      require("gitsigns").reset_buffer()
    end)
    map("n", "<leader>gs", function()
      require("gitsigns").stage_hunk()
    end)
    map("n", "<leader>gu", function()
      require("gitsigns").undo_stage_hunk()
    end)
    map("n", "<leader>gd", function()
      require("gitsigns").diffthis()
    end)
  end

  -- Telescope
  if utils.is_available "telescope.nvim" then
    -- Buffer
    map("n", "<leader>bl", function()
      require("telescope.builtin").buffers()
    end)

    -- Git
    map("n", "<leader>gb", function()
      require("telescope.builtin").git_branches()
    end)
    map("n", "<leader>gc", function()
      require("telescope.builtin").git_commits()
    end)
    map("n", "<leader>gt", function()
      require("telescope.builtin").git_status()
    end)

    -- File
    map("n", "<leader>fd", "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<CR>")
    map("n", "<leader>ff", function()
      require("telescope.builtin").find_files()
    end)
    map("n", "<leader>fF", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>")
    map("n", "<leader>fF", function()
      require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
    end)
    map("n", "<leader>fo", function()
      require("telescope.builtin").oldfiles()
    end)

    -- LSP
    map("n", "<leader>lD", function()
      require("telescope.builtin").diagnostics()
    end)
    map("n", "<leader>le", function()
      require("telescope.builtin").lsp_definitions()
    end)
    map("n", "<leader>lr", function()
      require("telescope.builtin").lsp_references()
    end)
    map("n", "<leader>ls", function()
      require("telescope.builtin").lsp_document_symbols()
    end)

    -- Search
    map("n", "<leader>sc", function()
      require("telescope.builtin").commands()
    end)
    map("n", "<leader>sh", function()
      require("telescope.builtin").help_tags()
    end)
    map("n", "<leader>sk", function()
      require("telescope.builtin").keymaps()
    end)
    map("n", "<leader>sm", function()
      require("telescope.builtin").man_pages()
    end)
    map("n", "<leader>sn", function()
      require("telescope").extensions.notify.notify()
    end)
    map("n", "<leader>sr", function()
      require("telescope.builtin").registers()
    end)
    map("n", "<leader>st", function()
      require("telescope.builtin").live_grep()
    end)
    -- Project
    if utils.is_available "project.nvim" then
      -- Standalone
      map("n", "<leader>P", function()
        require("telescope").extensions.projects.projects()
      end)

      -- Search
      map("n", "<leader>sp", function()
        require("telescope").extensions.projects.projects()
      end)
    end
  end
end

--- INSERT MODE ---
--
-- Move lines up and down in insert mode
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi")
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi")

-- Save File
map("i", "<C-s>", "<Esc><cmd>w<CR>")

--- VISUAL MODE ---
--
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<CR>==")
map("v", "<A-k>", "<cmd>m .-2<CR>==")

-- Comment
if utils.is_available "Comment.nvim" then
  map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

--- VISUAL BLOCK MODE ---
--
-- Move text up and down
map("x", "J", "<cmd>move '>+1<CR>gv-gv")
map("x", "K", "<cmd>move '<-2<CR>gv-gv")
map("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv")
map("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv")

-- disable Ex mode:
map("n", "Q", "<Nop>")

--- TERMINAL MODE ---
--
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], {})
  vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\><C-n>]], {})
  vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], {})
  vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], {})
  vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], {})
  vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], {})
end

augroup("TermMappings", {})
cmd("TermOpen", {
  desc = "Set terminal keymaps",
  group = "TermMappings",
  callback = _G.set_terminal_keymaps,
})

return M
