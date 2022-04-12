local M = {}

local utils = require "core.utils"

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  ["w"] = { "<cmd>w<CR>", "Save" },
  ["q"] = { "<cmd>q<CR>", "Quit" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["P"] = { "Projects" },
  ["."] = { "<cmd>cd %:p:h<CR>", "Set CWD" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Hover Diagnostic" },
    f = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  },

  f = {
    name = "File",
    i = { "gg=G", "Indent All" },
    p = { "1<C-g>", "Show Full Path" },
    r = { "<cmd>e<CR>", "Reload" },
    R = { "<cmd>e!<CR>", "Discard Changes and Reload" },
    s = { "<cmd>w<CR>", "Save" },
    S = { "ggVG", "Select All" },
  },

  s = {
    name = "Search",
    f = { "<cmd>FZF<CR>", "File(FZF)" },
  },
}

local extra_sections = {
  b = "Buffer",
  f = "File",
  g = "Git",
  l = "LSP",
  s = "Search",
  t = "Terminal",
  S = "Session",
}

local function init_table(idx)
  if not mappings[idx] then
    mappings[idx] = { name = extra_sections[idx] }
  end
end

-- Buffer
init_table "b"
mappings.b.p = { "<cmd>bp<CR>", "Previous" }
mappings.b.n = { "<cmd>bn<CR>", "Next" }
if utils.is_available "bufferline.nvim" then
  mappings.b.c = { "<cmd>BufferLinePickClose<CR>", "Pick Close" }
  mappings.b.j = { "<cmd>BufferLinePick<CR>", "Jump To" }
  mappings.b.N = { "<cmd>BufferLineMoveNext<CR>", "Move To Right" }
  mappings.b.P = { "<cmd>BufferLineMovePrev<CR>", "Move To Left" }
end

-- SessionManager
if utils.is_available "neovim-session-manager" then
  -- Session
  init_table "S"
  mappings.S.d = { "<cmd>SessionManage delete_session<CR>", "Delete" }
  mappings.S.l = { "<cmd>SessionManage load_last_session<CR>", "Load Last" }
  mappings.S.L = { "<cmd>SessionManage load_session<CR>", "List All" }
  mappings.S.s = { "<cmd>SessionManager save_current_session<CR>", "Save" }

  -- Search
  init_table "s"
  mappings.s.s = { "<cmd>SessionManage load_session<CR>", "Session" }
end

-- NvimTree
if utils.is_available "nvim-tree.lua" then
  mappings.e = { "<cmd>NvimTreeToggle<CR>", "Toggle Explorer" }
  mappings.o = { "<cmd>NvimTreeFocus<CR>", "Focus Explorer" }
end

-- Dashboard
if utils.is_available "dashboard-nvim" then
  mappings.d = { "<cmd>Dashboard<CR>", "Dashboard" }
  mappings.m = { "<cmd>DashboardJumpMarks<CR>", "Bookmarks" }

  -- File
  init_table "f"
  mappings.f.n = { "<cmd>DashboardNewFile<CR>", "New File" }
end

-- Comment
if utils.is_available "Comment.nvim" then
  mappings["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "Comment" }
end

-- VimBbye
if utils.is_available "vim-bbye" then
  mappings.c = { "<cmd>Bdelete!<CR>", "Close Buffer" }

  -- File
  init_table "f"
  mappings.f.c = { "<cmd>Bdelete<CR>", "Close" }
  mappings.f.C = { "<cmd>Bdelete!<CR>", "Close Unsaved" }

  -- Buffer
  init_table "b"
  mappings.b.d = { "<cmd>Bdelete<CR>", "Delete" }
  mappings.b.D = { "<cmd>Bdelete!<CR>", "Delete Unsaved" }
end

-- GitSigns
if utils.is_available "gitsigns.nvim" then
  init_table "g"
  mappings.g.j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" }
  mappings.g.k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" }
  mappings.g.l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" }
  mappings.g.p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" }
  mappings.g.h = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" }
  mappings.g.r = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" }
  mappings.g.s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" }
  mappings.g.u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" }
  mappings.g.d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "Diff" }
end

-- ToggleTerm
if utils.is_available "nvim-toggleterm.lua" then
  -- Git
  init_table "g"
  mappings.g.g = { "<cmd>lua require('core.utils').toggle_term_cmd('lazygit')<CR>", "Lazygit" }

  -- Terminal
  init_table "t"
  mappings.t.l = { "<cmd>lua require('core.utils').toggle_term_cmd('lazygit')<CR>", "Lazygit" }
  mappings.t.f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }
  mappings.t.h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }
  mappings.t.v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }
end

-- SymbolsOutline
if utils.is_available "symbols-outline.nvim" then
  init_table "l"
  mappings.l.S = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" }
end

-- Telescope
if utils.is_available "telescope.nvim" then
  -- Buffer
  init_table "b"
  mappings.b.l = { "<cmd>Telescope buffers<CR>", "List Opened" }

  -- Git
  init_table "g"
  mappings.g.t = { "<cmd>Telescope git_status<CR>", "Open changed file" }
  mappings.g.b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" }
  mappings.g.c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" }

  -- File
  init_table "f"
  mappings.f.d = { "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<CR>", "Find in Current Root" }
  mappings.f.f = { "<cmd>Telescope find_files<CR>", "Find" }
  mappings.f.F = { "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", "Find(Include Hidden)" }
  mappings.f.o = { "<cmd>Telescope oldfiles<CR>", "Open Recent" }

  -- LSP
  init_table "l"
  mappings.l.D = { "<cmd>Telescope diagnostics<CR>", "All Diagnostics" }
  mappings.l.e = { "<cmd>Telescope lsp_definitions<CR>", "Definition" }
  mappings.l.r = { "<cmd>Telescope lsp_references<CR>", "References" }
  mappings.l.s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" }

  -- Search
  init_table "s"
  mappings.s.b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" }
  mappings.s.c = { "<cmd>Telescope commands<CR>", "Commands" }
  mappings.s.h = { "<cmd>Telescope help_tags<CR>", "Help" }
  mappings.s.k = { "<cmd>Telescope keymaps<CR>", "Keymaps" }
  mappings.s.m = { "<cmd>Telescope man_pages<CR>", "Man Pages" }
  mappings.s.n = { "<cmd>Telescope notify<CR>", "Notifications" }
  mappings.s.r = { "<cmd>Telescope registers<CR>", "Registers" }
  mappings.s.t = { "<cmd>Telescope live_grep<CR>", "Text" }
  -- Project
  if utils.is_available "project.nvim" then
    mappings.P = { "<cmd>Telescope projects<CR>", "Projects" }
    mappings.s.p = { "<cmd>Telescope projects<CR>", "Projects" }
  end
end

which_key.register(require("core.utils").user_plugin_opts("which-key.register_n_leader", mappings), opts)

return M
