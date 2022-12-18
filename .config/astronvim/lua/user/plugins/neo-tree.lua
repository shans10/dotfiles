return {
  filesystem = {
    filtered_items = {
      visible = true -- show hidden/ignored files with different color
    }
  },
  -- Close neo-tree when file is opened
  event_handlers = {
    {
      event = "file_opened",
      handler = function(_)
        --auto close
        require("neo-tree").close_all()
      end
    },

  }
}
