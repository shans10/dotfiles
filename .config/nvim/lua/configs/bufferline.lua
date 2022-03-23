local M = {}

local function diagnostics_indicator(_, _, diagnostics)
  local result = {}
  local symbols = { error = "", warning = "", info = "" }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

function M.config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup(require("core.utils").user_plugin_opts("plugins.bufferline", {
    options = {
      offsets = {
        { filetype = "NvimTree", text = "Explorer", highlight = "PanelHeading", padding = 1 },
        { filetype = "neo-tree", text = "", padding = 1 },
        { filetype = "Outline", text = "", padding = 1 },
      },
      indicator_icon = "▎",
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      -- close_icon = "",
      show_close_icon = false,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 18,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      -- diagnostics = true,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = diagnostics_indicator,
    },

    --- Personal Highlights ---
    highlights = {
      background = {
        gui = "italic",
      },
      buffer_selected = {
        gui = "bold",
      },
      -- Selected buffer indicator
      indicator_selected = {
        guifg = "#51afef",
      },
      -- Separators
      separator = {
        guifg = "#d7ba7d",
      },
      -- Modified
      modified = {
        guifg = "#e06c75"
      },
      modified_visible = {
        guifg = "#e06c75",
      },
    },

    --- AstroVim Highlights ---
    -- highlights = {
    --   background = {
    --     guifg = { attribute = "fg", highlight = "BufferLineBackground" },
    --     -- guibg = { attribute = "bg", highlight = "BufferLineBackground" },
    --     gui = "italic",
    --   },
    --
    --   -- Buffers
    --   buffer_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineBufferSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineBufferSelected" },
    --     gui = "bold",
    --   },
    --   buffer_visible = {
    --     guifg = { attribute = "fg", highlight = "BufferLineBufferVisible" },
    --     guibg = { attribute = "bg", highlight = "BufferLineBufferVisible" },
    --   },
    --
    --   -- Duplicate
    --   -- duplicate = {
    --   --   guifg = { attribute = "fg", highlight = "BufferLineFill" },
    --   --   guibg = { attribute = "bg", highlight = "BufferLineFill" },
    --   --   gui = "bold",
    --   -- },
    --
    --   -- Diagnostics
    --   -- error = {
    --   --   guifg = { attribute = "fg", highlight = "BufferLineError" },
    --   --   guibg = { attribute = "bg", highlight = "BufferLineError" },
    --   --   gui = "italic"
    --   -- },
    --   -- error_diagnostic = {
    --   --   guifg = { attribute = "fg", highlight = "BufferLineErrorDiagnostic" },
    --   --   guibg = { attribute = "bg", highlight = "BufferLineErrorDiagnostic" },
    --   --   gui = "italic"
    --   -- },
    --
    --   -- Close buttons
    --   close_button = {
    --     guifg = { attribute = "fg", highlight = "BufferLineCloseButton" },
    --     -- guibg = { attribute = "bg", highlight = "BufferLineCloseButton" },
    --   },
    --   close_button_visible = {
    --     guifg = { attribute = "fg", highlight = "BufferLineCloseButtonVisible" },
    --     guibg = { attribute = "bg", highlight = "BufferLineCloseButtonVisible" },
    --   },
    --   close_button_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineCloseButtonSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineCloseButtonSelected" },
    --   },
    --
    --   -- Base fill background
    --   fill = {
    --     guifg = { attribute = "fg", highlight = "BufferLineFill" },
    --     -- guibg = { attribute = "bg", highlight = "BufferLineFill" },
    --   },
    --
    --   -- Selected buffer indicator
    --   indicator_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineIndicatorSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineIndicatorSelected" },
    --   },
    --
    --   -- Modified
    --   modified = {
    --     guifg = { attribute = "fg", highlight = "BufferLineModified" },
    --     -- guibg = { attribute = "bg", highlight = "BufferLineModified" },
    --   },
    --   modified_visible = {
    --     guifg = { attribute = "fg", highlight = "BufferLineModifiedVisible" },
    --     guibg = { attribute = "bg", highlight = "BufferLineModifiedVisible" },
    --   },
    --   modified_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineModifiedSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineModifiedSelected" },
    --   },
    --
    --   -- Separators
    --   separator = {
    --     guifg = { attribute = "fg", highlight = "BufferLineSeparator" },
    --     -- guibg = { attribute = "bg", highlight = "BufferLineSeparator" },
    --   },
    --   separator_visible = {
    --     guifg = { attribute = "fg", highlight = "BufferLineSeparatorVisible" },
    --     guibg = { attribute = "bg", highlight = "BufferLineSeparatorVisible" },
    --   },
    --   separator_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineSeparatorSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineSeparatorSelected" },
    --   },
    --
    --   -- Tabs
    --   tab = {
    --     guifg = { attribute = "fg", highlight = "BufferLineTab" },
    --     guibg = { attribute = "bg", highlight = "BufferLineTab" },
    --   },
    --   tab_selected = {
    --     guifg = { attribute = "fg", highlight = "BufferLineTabSelected" },
    --     guibg = { attribute = "bg", highlight = "BufferLineTabSelected" },
    --   },
    --   tab_close = {
    --     guifg = { attribute = "fg", highlight = "BufferLineTabClose" },
    --     guibg = { attribute = "bg", highlight = "BufferLineTabClose" },
    --   },
    -- },
  }))
end

return M
