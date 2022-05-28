local M = {}

local utils = require "core.utils"

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  local mappings = {
    n = {
      ["<leader>"] = {
        ["w"] = { "<cmd>w<cr>", "Save" },
        ["q"] = { "<cmd>q<cr>", "Quit" },
        ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
        ["P"] = { "Projects" },
        ["."] = { "<cmd>cd %:p:h<cr>", "Set CWD" },
        ["U"] = { require("core.utils").toggle_url_match, "Toggle URL Highlights" },

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
          n = { "<cmd>enew<cr>", "New File" },
          p = { "1<C-g>", "Show Full Path" },
          r = { "<cmd>e<cr>", "Reload" },
          R = { "<cmd>e!<cr>", "Discard Changes and Reload" },
          s = { "<cmd>w<cr>", "Save" },
          S = { "ggVG", "Select All" },
        },

        s = {
          name = "Search",
          f = { "<cmd>FZF<cr>", "File(FZF)" },
        },
      },

      g = {
        d = { vim.lsp.buf.definition, "Go to definition" },
        D = { vim.lsp.buf.declaration, "Go to declaration" },
        I = { vim.lsp.buf.implementation, "Go to implementation" },
        r = { vim.lsp.buf.references, "Go to references" },
        o = { vim.diagnostic.open_float, "Hover diagnostic" },
        l = { vim.diagnostic.open_float, "Hover diagnostic" },
        k = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
        j = { vim.diagnostic.goto_next, "Go to next diagnostic" },
        h = { vim.lsp.buf.hover, "Hover symbol details" },
        R = { vim.lsp.buf.rename, "Rename current symbol" },
        x = { utils.url_opener_cmd(), "Open the file under cursor with system app" },
      },
      ["["] = {
        d = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
      },
      ["]"] = {
        d = { vim.diagnostic.goto_next, "Go to next diagnostic" },
      },
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

    local function init_table(mode, prefix, idx)
    if not mappings[mode][prefix][idx] then
      mappings[mode][prefix][idx] = { name = extra_sections[idx] }
    end
  end

  -- Buffer
  init_table("n", "<leader>", "b")
  mappings.n["<leader>"].b.p = { "<cmd>bp<cr>", "Previous" }
  mappings.n["<leader>"].b.n = { "<cmd>bn<cr>", "Next" }
  if utils.is_available "bufferline.nvim" then
    mappings.n["<leader>"].b.c = { "<cmd>BufferLinePickClose<cr>", "Pick Close" }
    mappings.n["<leader>"].b.j = { "<cmd>BufferLinePick<cr>", "Jump To" }
    mappings.n["<leader>"].b.N = { "<cmd>BufferLineMoveNext<cr>", "Move To Right" }
    mappings.n["<leader>"].b.P = { "<cmd>BufferLineMovePrev<cr>", "Move To Left" }
  end

  -- SessionManager
  if utils.is_available "neovim-session-manager" then
    -- Session
    init_table("n", "<leader>", "S")
    mappings.n["<leader>"].S.d = { "<cmd>SessionManager! delete_session<cr>", "Delete" }
    mappings.n["<leader>"].S.l = { "<cmd>SessionManager! load_last_session<cr>", "Load Last" }
    mappings.n["<leader>"].S.L = { "<cmd>SessionManager! load_session<cr>", "List All" }
    mappings.n["<leader>"].S.s = { "<cmd>SessionManager! save_current_session<cr>", "Save" }

    -- Search
    init_table("n", "<leader>", "s")
    mappings.n["<leader>"].s.s = { "<cmd>SessionManager! load_session<cr>", "Session" }
  end

  -- NvimTree
  if utils.is_available "nvim-tree.lua" then
    mappings.n["<leader>"].e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" }
    mappings.n["<leader>"].o = { "<cmd>NvimTreeFocus<cr>", "Focus Explorer" }
  end

  -- Alpha Dashboard
  if utils.is_available "alpha-nvim" then
    mappings.n["<leader>"].d = { "<cmd>Alpha<cr>", "Alpha Dashboard" }
  end

  -- Comment
  if utils.is_available "Comment.nvim" then
    mappings.n["<leader>"]["/"] = {
      function()
        require("Comment.api").toggle_current_linewise()
      end,
      "Comment",
    }
  end

  -- Bufdelete
  if utils.is_available "bufdelete.nvim" then
    mappings.n["<leader>"].c = { "<cmd>Bdelete!<cr>", "Close Buffer" }

    -- File
    init_table("n", "<leader>", "f")
    mappings.n["<leader>"].f.c = { "<cmd>Bdelete<cr>", "Close" }
    mappings.n["<leader>"].f.C = { "<cmd>Bdelete!<cr>", "Close Unsaved" }

    -- Buffer
    init_table("n", "<leader>", "b")
    mappings.n["<leader>"].b.d = { "<cmd>Bdelete<cr>", "Delete" }
    mappings.n["<leader>"].b.D = { "<cmd>Bdelete!<cr>", "Delete Unsaved" }

  -- Standalone(If bufdelete is not installed)
  else
    mappings.n["<leader>"].c = { "<cmd>bdelete!<cr>", "Close Buffer" }

    -- File
    init_table("n", "<leader>", "f")
    mappings.n["<leader>"].f.c = { "<cmd>bdelete<cr>", "Close" }
    mappings.n["<leader>"].f.C = { "<cmd>bdelete!<cr>", "Close Unsaved" }

    -- Buffer
    init_table("n", "<leader>", "b")
    mappings.n["<leader>"].b.d = { "<cmd>bdelete<cr>", "Delete" }
    mappings.n["<leader>"].b.D = { "<cmd>bdelete!<cr>", "Delete Unsaved" }
  end

  -- GitSigns
  if utils.is_available "gitsigns.nvim" then
    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.j = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Next Hunk",
    }
    mappings.n["<leader>"].g.k = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Prev Hunk",
    }
    mappings.n["<leader>"].g.l = {
      function()
        require("gitsigns").blame_line()
      end,
      "Blame",
    }
    mappings.n["<leader>"].g.p = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview Hunk",
    }
    mappings.n["<leader>"].g.h = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset Hunk",
    }
    mappings.n["<leader>"].g.r = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset Buffer",
    }
    mappings.n["<leader>"].g.s = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage Hunk",
    }
    mappings.n["<leader>"].g.u = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Undo Stage Hunk",
    }
    mappings.n["<leader>"].g.d = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff",
    }
  end

  -- ToggleTerm
  if utils.is_available "nvim-toggleterm.lua" then
    -- Git
    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.g = {
      function()
        require("core.utils").toggle_term_cmd "lazygit"
      end,
      "Lazygit",
    }

    -- Terminal
    init_table("n", "<leader>", "t")
    mappings.n["<leader>"].t.l = {
      function()
        require("core.utils").toggle_term_cmd "lazygit"
      end,
      "Lazygit",
    }
    mappings.n["<leader>"].t.f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }
    mappings.n["<leader>"].t.h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }
    mappings.n["<leader>"].t.v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }
  end

  -- Aerial
  if utils.is_available "aerial.nvim" then
    init_table("n", "<leader>", "l")
    mappings.n["<leader>"].l.S = { "<cmd>AerialToggle<cr>", "Symbols Outline" }
  end

  -- Telescope
  if utils.is_available "telescope.nvim" then
    -- Bookmarks
    mappings.n["<leader>"].m = {
      function()
        require("telescope.builtin").marks()
      end,
      "Bookmarks",
    }

    -- Buffer
    init_table("n", "<leader>", "b")
    mappings.n["<leader>"].b.l = {
      function()
        require("telescope.builtin").buffers()
      end,
      "List Opened",
    }

    -- Git
    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.t = {
      function()
        require("telescope.builtin").git_status()
      end,
      "Open Changed File",
    }
    mappings.n["<leader>"].g.b = {
      function()
        require("telescope.builtin").git_branches()
      end,
      "Checkout Branch",
    }
    mappings.n["<leader>"].g.c = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "Checkout Commit",
    }

    -- File
    init_table("n", "<leader>", "f")
    mappings.n["<leader>"].f.d = { "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>", "Find in CWD" }
    mappings.n["<leader>"].f.f = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find Files",
    }
    mappings.n["<leader>"].f.F = {
      function()
        require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
      end,
      "Find(Include Hidden)",
    }
    mappings.n["<leader>"].f.o = {
      function()
        require("telescope.builtin").oldfiles()
      end,
      "Open Recent",
    }

    -- LSP
    init_table("n", "<leader>", "l")
    mappings.n["<leader>"].l.D = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "All Diagnostics",
    }
    mappings.n["<leader>"].l.e = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "Definition",
    }
    mappings.n["<leader>"].l.r = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "References",
    }
    mappings.n["<leader>"].l.s = {
      function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
          require("telescope").extensions.aerial.aerial()
        else
          require("telescope.builtin").lsp_document_symbols()
        end
      end,
      "Document Symbols",
    }

    -- Search
    init_table("n", "<leader>", "s")
    mappings.n["<leader>"].s.c = {
      function()
        require("telescope.builtin").commands()
      end,
      "Commands",
    }
    mappings.n["<leader>"].s.h = { "<cmd>Telescope help_tags<cr>", "Help" }
    mappings.n["<leader>"].s.h = {
      function()
        require("telescope.builtin").help_tags()
      end,
      "Help",
    }
    mappings.n["<leader>"].s.k = {
      function()
        require("telescope.builtin").keymaps()
      end,
      "Keymaps",
    }
    mappings.n["<leader>"].s.m = {
      function()
        require("telescope.builtin").man_pages()
      end,
      "Man Pages",
    }
    mappings.n["<leader>"].s.n = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      "Notifications",
    }
    mappings.n["<leader>"].s.r = {
      function()
        require("telescope.builtin").registers()
      end,
      "Registers",
    }
    mappings.n["<leader>"].s.t = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Text",
    }
    -- Project
    if utils.is_available "project.nvim" then
      -- Standalone
      mappings.n["<leader>"].P = {
        function()
          require("telescope").extensions.projects.projects()
        end,
        "Projects",
      }

      -- Search
      mappings.n["<leader>"].s.p = {
        function()
          require("telescope").extensions.projects.projects()
        end,
        "Projects",
      }
    end
  end

  mappings = require("core.utils").user_plugin_opts("which-key.register_mappings", mappings)
  -- support previous legacy notation, deprecate at some point
  mappings.n["<leader>"] = require("core.utils").user_plugin_opts("which-key.register_n_leader", mappings.n["<leader>"])
  for mode, prefixes in pairs(mappings) do
    for prefix, mapping_table in pairs(prefixes) do
      which_key.register(mapping_table, {
        mode = mode,
        prefix = prefix,
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
    end
  end
end

return M
