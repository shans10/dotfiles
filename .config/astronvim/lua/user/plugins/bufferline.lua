return {
  options = {
    close_command = "bdelete! %d",
    offsets = {
      { filetype = "neo-tree", text = "Explorer", highlight = "Title", padding = 1 },
      { filetype = "aerial", text = "Symbols Outline", highlight = "Title", padding = 1 },
    },
    show_duplicate_prefix = false,
  },
  highlights = require("catppuccin.groups.integrations.bufferline").get()
}
