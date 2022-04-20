local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if status_ok then
    local g = vim.g

    g.nvim_tree_git_hl = 1
    g.nvim_tree_root_folder_modifier = ":t"
    g.nvim_tree_respect_buf_cwd = 1

    g.nvim_tree_icons = {
      default = "",
      symlink = "",
      git = {
        deleted = "",
        ignored = "◌",
        renamed = "➜",
        staged = "✓",
        unmerged = "",
        unstaged = "✗",
        untracked = "★",
      },
      folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
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
      open_on_tab = false,
      hijack_cursor = false,
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
          quit_on_open = true,
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
      },
      renderer = {
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
      },
    }))
  end
end

return M
