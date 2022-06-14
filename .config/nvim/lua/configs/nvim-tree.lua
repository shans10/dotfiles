local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if status_ok then
    nvimtree.setup(doomnvim.user_plugin_opts("plugins.nvim-tree", {
      disable_netrw = true,
      update_cwd = true,
      respect_buf_cwd = true,
      renderer = {
        root_folder_modifier = ":t",
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      ignore_ft_on_setup = {
        "dashboard",
        "startify",
        "alpha",
      },
      filters = {
        dotfiles = false,
        custom = {
          ".git",
          "node_modules",
          ".cache",
          "__pycache__",
        },
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 200,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }))
  end
end

return M
