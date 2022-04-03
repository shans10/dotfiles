local M = {}

function M.config()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local default_setup = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    key_labels = {},
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    popup_mappings = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 10,
      align = "left",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = "auto",
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local mappings = {
    ["d"] = { "Dashboard" },
    ["e"] = { "Explorer" },
    ["w"] = { "Save" },
    ["q"] = { "Quit" },
    ["c"] = { "Close Buffer" },
    ["h"] = { "No Highlight" },
    ["/"] = { "Comment" },
    ["P"] = { "Projects" },
    ["."] = { "<cmd>cd %:p:h<cr>", "Set CWD" },

    p = {
      name = "Packer",
      c = { "Compile" },
      i = { "Install" },
      s = { "Sync" },
      S = { "Status" },
      u = { "Update" },
    },

    g = {
      name = "Git",
      b = { "Checkout branch" },
      c = { "Checkout commit" },
      d = { "Diff" },
      g = { "Lazygit" },
      h = { "Reset Hunk" },
      j = { "Next Hunk" },
      k = { "Prev Hunk" },
      l = { "Blame" },
      p = { "Preview Hunk" },
      r = { "Reset Buffer" },
      s = { "Stage Hunk" },
      t = { "Open changed file" },
      u = { "Undo Stage Hunk" },
    },

    l = {
      name = "LSP",
      a = { "Code Action" },
      d = { "Hover Diagnostic" },
      D = { "All Diagnostics" },
      e = { "Definitions" },
      f = { "Format" },
      i = { "Info" },
      I = { "Installer Info" },
      r = { "References" },
      R = { "Rename" },
      s = { "Document Symbols" },
      S = { "Symbols Outline" },
    },

    s = {
      name = "Search",
      b = { "Checkout Branch" },
      c = { "Commands" },
      f = { "Files(FZF)" },
      h = { "Help" },
      k = { "Keymaps" },
      m = { "Man Pages" },
      n = { "Notifications" },
      p = { "Projects" },
      r = { "Registers" },
      s = { "Sessions" },
      t = { "Text" },
    },

    t = {
      name = "Terminal",
      l = { "LazyGit" },
      f = { "Float" },
      h = { "Horizontal" },
      v = { "Vertical" },
    },

    f = {
      name = "Files",
      c = { "Close" },
      C = { "Close Unsaved" },
      d = { "Find in Current Root" },
      f = { "Find" },
      F = { "Find(Include Hidden)" },
      i = { "Indent All" },
      o = { "Open Recent" },
      p = { "Show Full Path" },
      r = { "Reload" },
      R = { "Discard Changes and Reload" },
      s = { "Save" },
      S = { "Select All" },
    },

    b = {
      name = "Buffers",
      c = { "Pick Close" },
      d = { "Close" },
      D = { "Close Unsaved   " },
      j = { "Jump To" },
      l = { "List Open" },
      n = { "Go to Next" },
      p = { "Go to Prev" },
    },

    S = {
      name = "Session",
      d = { "Delete" },
      l = { "Load Last" },
      L = { "List All" },
      s = { "Save" },
    },
  }

  which_key.setup(require("core.utils").user_plugin_opts("plugins.which-key", default_setup))
  which_key.register(require("core.utils").user_plugin_opts("which-key.register_n_leader", mappings), opts)
end

return M
