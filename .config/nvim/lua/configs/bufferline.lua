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
  if status_ok then
    bufferline.setup(doomnvim.user_plugin_opts("plugins.bufferline", {
      options = {
        offsets = {
          { filetype = "NvimTree", text = "Explorer", highlight = "PanelHeading", padding = 1 },
          { filetype = "neo-tree", text = "Explorer", highlight = "PanelHeading", padding = 1 },
          { filetype = "Outline", text = "", padding = 1 },
        },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        show_close_icon = false,
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        diagnostics_indicator = diagnostics_indicator,
      },
    }))
  end
end

return M
