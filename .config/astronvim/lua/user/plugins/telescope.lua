return {
  extensions = {
    file_browser = {
      previewer = false,
      theme = "dropdown"
    },
    project = {
      base_dirs = {
        "~/Programming",
      },
      theme = "dropdown",
      order_by = "asc",
      sync_with_nvim_tree = true,
    }
  },
  pickers = {
    buffers = {
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
}
