local get_icon = require("astronvim.utils").get_icon
local is_available = require "astronvim.utils".is_available
local st = require "astronvim.utils.status"
local separators = {
  left = { "", " " }, -- separator for the left side of the statusline
  right = { " ", "" } -- separator for the right side of the statusline
}

-- Statusline components table
return {
  -- default highlight for the entire statusline
  hl = { fg = "fg", bg = "bg" },
  -- each element following is a component in st module

  -- add the vim mode component
  st.component.mode {
    -- enable mode text with padding as well as an icon before it
    mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
    -- surround the component with a separators
    surround = {
      -- it's a left element, so use the left separator
      separator = separators.left,
      -- set the color of the surrounding based on the current mode using st module
      color = function() return { main = st.hl.mode_bg(), right = "blank_bg" } end,
    },
  },
  -- we want an empty space here so we can use the component builder to make a new section with just an empty string
  st.component.builder {
    { provider = "" },
    -- define the surrounding separator and colors to be used inside of the component
    -- and the color to the right of the separated out section
    surround = { separator = separators.left, color = { main = "blank_bg", right = "file_info_bg" } },
  },
  -- add a section for the currently opened file information
  st.component.file_info {
    -- enable the file_icon and disable the highlighting based on filetype
    file_icon = {
      hl = false,
      padding = { left = 0 }
    },
    filename = { fallback = "Empty" },
    -- add padding
    padding = { right = 1 },
    -- define the section separator
    surround = { separator = separators.left, condition = false },
  },
  -- add a component for the current git branch if it exists and use no separator for the sections
  st.component.git_branch { surround = { separator = "none" } },
  -- add a component for the current git diff if it exists and use no separator for the sections
  st.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
  -- fill the rest of the statusline
  -- the elements after this will appear in the middle of the statusline
  st.component.fill(),
  -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
  st.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
  -- fill the rest of the statusline
  -- the elements after this will appear on the right of the statusline
  st.component.fill(),
  -- add a component for the current diagnostics if it exists
  st.component.diagnostics {
    surround = { separator = "right" },
    on_click = {
      name = "heirline_diagnostic",
      callback = function()
        if is_available "telescope.nvim" then
          vim.defer_fn(function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, 100)
        end
      end,
    },
  },
  -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
  st.component.lsp { lsp_progress = false, surround = { separator = separators.right } },
  -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
  -- all of the children of this table will be treated together as a single component
  {
    -- define a simple component where the provider is just a folder icon
    st.component.builder {
      -- get_icon gets the user interface icon for a closed folder with a space after it
      { provider = get_icon "FolderClosed" },
      -- add padding after icon
      padding = { right = 1 },
      -- set the foreground color to be used for the icon
      hl = { fg = "bg" },
      -- use the right separator and define the background color
      surround = { separator = separators.right, color = "folder_icon_bg" },
    },
    -- add a file information component and only show the current working directory name
    st.component.file_info {
      -- we only want filename to be used and we can change the fname
      -- function to get the current working directory name
      filename = { fname = function(nr) return vim.fn.getcwd(nr) end, padding = { left = 1 } },
      -- disable all other elements of the file_info component
      file_icon = false,
      file_modified = false,
      file_read_only = false,
      -- use no separator for this part but define a background color
      surround = { separator = "none", color = "file_info_bg", condition = false },
    },
  },
  -- the final component of the NvChad statusline is the navigation section
  -- this is very similar to the previous current working directory section with the icon
  { -- make nav section with icon border
    -- define a custom component with just a file icon
    st.component.builder {
      { provider = get_icon "ScrollText" },
      -- add padding after icon
      padding = { right = 1 },
      -- set the icon foreground
      hl = { fg = "bg" },
      -- use the right separator and define the background color
      -- as well as the color to the left of the separator
      surround = { separator = separators.right, color = { main = "nav_icon_bg", left = "file_info_bg" } },
    },
    -- add a navigation component and just display the percentage of progress in the file
    st.component.nav {
      -- add some padding for the percentage provider
      percentage = { padding = { right = 1 } },
      -- disable all other providers
      ruler = false,
      scrollbar = false,
      -- use no separator and define the background color
      surround = { separator = "none", color = "file_info_bg" },
    },
  },
}
