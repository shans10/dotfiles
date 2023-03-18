return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true -- show hidden/ignored files with different color
      }
    },
    sources = {
      "filesystem",
    },
    add_blank_line_top = false,
    enable_diagnostics = false
  }
}
