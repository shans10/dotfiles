local function setup_colors()
  local StatusLine = tnvim.get_hlgroup("StatusLine")
  local CursorLine = tnvim.get_hlgroup("CursorLine")
  local Normal = tnvim.get_hlgroup("Normal")
  local Conditional = tnvim.get_hlgroup("Conditional")
  local String = tnvim.get_hlgroup("String")
  local HeirlineNormal = tnvim.get_hlgroup("HerlineNormal", { fg = "#0000ff", bg = "#000000" })
  local HeirlineInsert = tnvim.get_hlgroup("HeirlineInsert", { fg = "#00ff00", bg = "#000000" })
  local HeirlineVisual = tnvim.get_hlgroup("HeirlineVisual", { fg = "#ff00ff", bg = "#000000" })
  local HeirlineReplace = tnvim.get_hlgroup("HeirlineReplace", { fg = "#ff0000", bg = "#000000" })
  local HeirlineCommand = tnvim.get_hlgroup("HeirlineCommand", { fg = "#ffff00", bg = "#000000" })
  local HeirlineInactive = tnvim.get_hlgroup("HeirlineInactive", { fg = "#666666", bg = "#000000" })
  local GitSignsAdd = tnvim.get_hlgroup("GitSignsAdd")
  local GitSignsChange = tnvim.get_hlgroup("GitSignsChange")
  local GitSignsDelete = tnvim.get_hlgroup("GitSignsDelete")
  local DiagnosticError = tnvim.get_hlgroup("DiagnosticError")
  local DiagnosticWarn = tnvim.get_hlgroup("DiagnosticWarn")
  local DiagnosticInfo = tnvim.get_hlgroup("DiagnosticInfo")
  local DiagnosticHint = tnvim.get_hlgroup("DiagnosticHint")
  local colors = tnvim.user_plugin_opts("heirline.colors", {
    fg = StatusLine.fg,
    bg = StatusLine.bg,
    normal_fg = Normal.fg,
    cwd_bg = CursorLine.bg,
    git_branch_fg = Conditional.fg,
    ts_fg = String.fg,
    git_added = GitSignsAdd.fg,
    git_changed = GitSignsChange.fg,
    git_removed = GitSignsDelete.fg,
    diag_ERROR = DiagnosticError.fg,
    diag_WARN = DiagnosticWarn.fg,
    diag_INFO = DiagnosticInfo.fg,
    diag_HINT = DiagnosticHint.fg,
    normal = tnvim.status.hl.lualine_mode("normal", HeirlineNormal.fg),
    insert = tnvim.status.hl.lualine_mode("insert", HeirlineInsert.fg),
    visual = tnvim.status.hl.lualine_mode("visual", HeirlineVisual.fg),
    replace = tnvim.status.hl.lualine_mode("replace", HeirlineReplace.fg),
    command = tnvim.status.hl.lualine_mode("command", HeirlineCommand.fg),
    inactive = HeirlineInactive.fg,
  })

  return colors
end

return { setup_colors = setup_colors }
