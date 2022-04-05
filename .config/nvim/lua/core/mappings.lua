local M = {}

local config = require("core.utils").user_settings()

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", opts)
map("n", "<C-j>", "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", opts)
map("n", "<C-k>", "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", opts)
map("n", "<C-l>", "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", opts)

-- Resize with arrows
map("n", "<C-Up>", "<cmd>lua require'smart-splits'.resize_up(2)<cr>", opts)
map("n", "<C-Down>", "<cmd>lua require'smart-splits'.resize_down(2)<cr>", opts)
map("n", "<C-Left>", "<cmd>lua require'smart-splits'.resize_left(2)<cr>", opts)
map("n", "<C-Right>", "<cmd>lua require'smart-splits'.resize_right(2)<cr>", opts)

-- Navigate buffers
if config.enabled.bufferline then
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", opts)
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
  map("n", "}", "<cmd>BufferLineMoveNext<cr>", opts)
  map("n", "{", "<cmd>BufferLineMovePrev<cr>", opts)
else
  map("n", "<S-l>", "<cmd>bnext<CR>", opts)
  map("n", "<S-h>", "<cmd>bprevious<CR>", opts)
end

-- Move text up and down
map("n", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- Standard Operations
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>c", "<cmd>Bdelete!<CR>", opts)
map("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
map("n", "<leader>P", "<cmd>Telescope projects<CR>", opts)
map("n", "<leader>uc", "<cmd>exe \"edit\" stdpath(\"config\").\"/lua/user/init.lua\"<CR>", opts)

-- Packer
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", opts)
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", opts)
map("n", "<leader>ps", "<cmd>PackerSync<cr>", opts)
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", opts)
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", opts)

-- LSP
-- Leader key bindings
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", opts)
map("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)
map("n", "<leader>le", "<cmd>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- Normal bindings
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", opts)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>", opts)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

-- NvimTree
if config.enabled.nvim_tree then
  map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
  map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", opts)
end

-- NeoTree
-- if config.enabled.neo_tree then
--   map("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)
--   map("n", "<leader>o", "<cmd>Neotree focus<CR>", opts)
-- end

-- Dashboard
if config.enabled.dashboard then
  map("n", "<leader>d", "<cmd>Dashboard<CR>", opts)
  map("n", "<leader>fn", "<cmd>DashboardNewFile<CR>", opts)
  map("n", "<leader>m", "<cmd>DashboardJumpMarks<CR>", opts)
end

-- GitSigns
if config.enabled.gitsigns then
  map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)
  map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)
  map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", opts)
  map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opts)
  map("n", "<leader>gh", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", opts)
  map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opts)
  map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", opts)
  map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", opts)
  map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", opts)
end

-- Git
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", opts)
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)

-- Comment
if config.enabled.comment then
  map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", opts)
  map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
end

-- Files
map("n", "<leader>fc", "<cmd>Bdelete<CR>", opts)
map("n", "<leader>fC", "<cmd>Bdelete!<CR>", opts)
map("n", "<leader>fd", "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<CR>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fF", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", opts)
map("n", "<leader>fi", "gg=G<CR>", opts)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
map("n", "<leader>fp", "1<C-g><CR>", opts)
map("n", "<leader>fr", "<cmd>e<CR>", opts)
map("n", "<leader>fR", "<cmd>e!<CR>", opts)
map("n", "<leader>fs", "<cmd>w<CR>", opts)
map("n", "<leader>fS", "ggVG<CR>", opts)

-- Buffers
map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)
map("n", "<leader>bd", "<cmd>Bdelete<CR>", opts)
map("n", "<leader>bD", "<cmd>Bdelete!<CR>", opts)
map("n", "<leader>bj", "<cmd>BufferLinePick<CR>", opts)
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>bn", "<cmd>bn<CR>", opts)
map("n", "<leader>bp", "<cmd>bp<CR>", opts)

-- Search
map("n", "<leader>sb", "<cmd>Telescope git_branches<CR>", opts)
map("n", "<leader>sc", "<cmd>Telescope commands<CR>", opts)
map("n", "<leader>sf", "<cmd>FZF<CR>", opts)
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", opts)
map("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", opts)
map("n", "<leader>sn", "<cmd>Telescope notify<CR>", opts)
map("n", "<leader>sp", "<cmd>Telescope projects<CR>", opts)
map("n", "<leader>sr", "<cmd>Telescope registers<CR>", opts)
map("n", "<leader>st", "<cmd>Telescope live_grep<CR>", opts)

-- Sessions
map("n", "<leader>Sd", "<cmd>SessionManage delete_session<CR>", opts)
map("n", "<leader>Sl", "<cmd>SessionManage load_last_session<CR>", opts)
map("n", "<leader>SL", "<cmd>SessionManage load_session<CR>", opts)
map("n", "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", opts)

-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>", opts)

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>", opts)

-- Save in insert mode
map("i", "<C-s>", "<Esc><cmd>w<CR>", opts)

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<CR>", opts)

-- Terminal
if config.enabled.toggle_term then
  map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", opts)
  map("n", "<leader>gg", "<cmd>lua require('core.utils').toggle_term_cmd('lazygit')<CR>", opts)
  map("n", "<leader>tl", "<cmd>lua require('core.utils').toggle_term_cmd('lazygit')<CR>", opts)
  map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", opts)
  map("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", opts)
  map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opts)
end

-- SymbolsOutline
if config.enabled.symbols_outline then
  map("n", "<leader>lS", "<cmd>SymbolsOutline<CR>", opts)
end

-- Move lines up and down in normal mode
map("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
map("n", "<A-k>", "<cmd>m .-2<CR>==", opts)

-- Move lines up and down in normal mode
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<CR>==", opts)
map("v", "<A-k>", "<cmd>m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
map("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- disable Ex mode:
map("n", "Q", "<Nop>", opts)

function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd [[
  augroup TermMappings
    autocmd! TermOpen term://* lua set_terminal_keymaps()
  augroup END
]]

return M
