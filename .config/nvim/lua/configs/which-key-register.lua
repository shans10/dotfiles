local M = {}

local utils = require "core.utils"

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
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
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = { vim.diagnostic.open_float, "Hover Diagnostic" },
      f = { vim.lsp.buf.formatting_sync, "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      R = { vim.lsp.buf.rename, "Rename" },
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
    mappings["/"] = {
      function()
        require("Comment.api").toggle_current_linewise()
      end,
      "Comment",
    }
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
    mappings.g.j = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Next Hunk",
    }
    mappings.g.k = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Prev Hunk",
    }
    mappings.g.l = {
      function()
        require("gitsigns").blame_line()
      end,
      "Blame",
    }
    mappings.g.p = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview Hunk",
    }
    mappings.g.h = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset Hunk",
    }
    mappings.g.r = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset Buffer",
    }
    mappings.g.s = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage Hunk",
    }
    mappings.g.u = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Undo Stage Hunk",
    }
    mappings.g.d = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff",
    }
  end

  -- ToggleTerm
  if utils.is_available "nvim-toggleterm.lua" then
    -- Git
    init_table "g"
    mappings.g.g = {
      function()
        require("core.utils").toggle_term_cmd "lazygit"
      end,
      "Lazygit",
    }

    -- Terminal
    init_table "t"
    mappings.t.l = {
      function()
        require("core.utils").toggle_term_cmd "lazygit"
      end,
      "Lazygit",
    }
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
    mappings.b.l = {
      function()
        require("telescope.builtin").buffers()
      end,
      "List Opened",
    }

    -- Git
    init_table "g"
    mappings.g.t = {
      function()
        require("telescope.builtin").git_status()
      end,
      "Open Changed File",
    }
    mappings.g.b = {
      function()
        require("telescope.builtin").git_branches()
      end,
      "Checkout Branch",
    }
    mappings.g.c = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "Checkout Commit",
    }

    -- File
    init_table "f"
    mappings.f.d = { "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<CR>", "Find in CWD" }
    mappings.f.f = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find Files",
    }
    mappings.f.F = {
      function()
        require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
      end,
      "Find(Include Hidden)",
    }
    mappings.f.o = {
      function()
        require("telescope.builtin").oldfiles()
      end,
      "Open Recent",
    }

    -- LSP
    init_table "l"
    mappings.l.D = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "All Diagnostics",
    }
    mappings.l.e = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "Definition",
    }
    mappings.l.r = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "References",
    }
    mappings.l.s = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "Document Symbols",
    }

    -- Search
    init_table "s"
    mappings.s.c = {
      function()
        require("telescope.builtin").commands()
      end,
      "Commands",
    }
    mappings.s.h = { "<cmd>Telescope help_tags<CR>", "Help" }
    mappings.s.h = {
      function()
        require("telescope.builtin").help_tags()
      end,
      "Help",
    }
    mappings.s.k = {
      function()
        require("telescope.builtin").keymaps()
      end,
      "Keymaps",
    }
    mappings.s.m = {
      function()
        require("telescope.builtin").man_pages()
      end,
      "Man Pages",
    }
    mappings.s.n = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      "Notifications",
    }
    mappings.s.r = {
      function()
        require("telescope.builtin").registers()
      end,
      "Registers",
    }
    mappings.s.t = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Text",
    }
    -- Project
    if utils.is_available "project.nvim" then
      -- Standalone
      mappings.P = {
        function()
          require("telescope").extensions.projects.projects()
        end,
        "Projects",
      }

      -- Search
      mappings.s.p = {
        function()
          require("telescope").extensions.projects.projects()
        end,
        "Projects",
      }
    end
  end

  which_key.register(require("core.utils").user_plugin_opts("which-key.register_n_leader", mappings), opts)
end

return M
