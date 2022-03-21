local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  local g = vim.g

  g.nvim_tree_indent_markers = 0

  g.nvim_tree_git_hl = 1
  g.nvim_tree_root_folder_modifier = ":t"
  g.nvim_tree_respect_buf_cwd = 1

  g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      --- Lunarvim ---
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",

      --- Astrovim ---
      -- deleted = "",
      -- ignored = "◌",
      -- renamed = "➜",
      -- staged = "✓",
      -- unmerged = "",
      -- unstaged = "✗",
      -- untracked = "★",
    },
    folder = {
      --- Lunarvim ---
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",

      --- Astrovim ---
      -- default = "",
      -- empty = "",
      -- empty_open = "",
      -- open = "",
      -- symlink = "",
      -- symlink_open = "",
    },
  }

  nvimtree.setup(require("core.utils").user_plugin_opts("plugins.nvim-tree", {
    active = true,
    on_config_done = nil,
    filters = {
      dotfiles = false,
      custom = {
        ".git",
        "node_modules",
        ".cache",
        "__pycache__",
      },
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_buffer_on_setup = false,
    ignore_ft_on_setup = {
      "dashboard",
      "startify",
      "alpha",
    },
    auto_reload_on_write = true,
    hijack_unnamed_buffer_when_opening = false,
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_to_buf_dir = {
      enable = true,
      auto_open = true,
    },
    auto_close = false,
    open_on_tab = false,
    -- quit_on_open = false,
    hijack_cursor = false,
    -- hide_root_folder = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    view = {
      width = 30,
      height = 30,
      side = "left",
      -- allow_resize = true,
      hide_root_folder = false,
      auto_resize = false,
      mappings = {
        custom_only = false,
        list = {},
      },
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 200,
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    actions = {
      change_dir = {
        global = false,
      },
      open_file = {
        resize_window = true,
        quit_on_open = false,
      },
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {},
      },
    },
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
      -- tree_width = 30,
    },
  }))
end

return M
