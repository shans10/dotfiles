return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-project.nvim"
  },
  opts = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    return require("astronvim.utils").extend_tbl(opts, {
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<C-z>"] = fb_actions.toggle_hidden,
            },
            n = {
              z = fb_actions.toggle_hidden,
            },
          },
          previewer = false,
          theme = "dropdown"
        },
        project = {
          base_dirs = {
            "~/Programming",
            "~/dotfiles",
            "~/.config/nvim",
          },
          theme = "dropdown",
          order_by = "asc",
          sync_with_nvim_tree = true,
        }
      },
      pickers = {
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
          ignore_current_buffer = true,
          previewer = false,
          sort_mru = true,
          theme = "dropdown"
        },
        find_files = {
          previewer = false,
          theme = "dropdown"
        },
        oldfiles = {
          previewer = false,
          theme = "dropdown"
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "project"
  end,
}
