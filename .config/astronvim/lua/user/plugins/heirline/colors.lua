local function setup_colors()
  local StatusLine = astronvim.get_hlgroup("StatusLine")
  local CursorLine = astronvim.get_hlgroup("CursorLine")
  local Normal = astronvim.get_hlgroup("Normal")
  local Conditional = astronvim.get_hlgroup("Conditional")
  local String = astronvim.get_hlgroup("String")
  local Search = astronvim.get_hlgroup("Search")
  local TypeDef = astronvim.get_hlgroup("TypeDef")
  local HeirlineNormal = astronvim.get_hlgroup("HerlineNormal", { fg = "#0000ff", bg = "#000000" })
  local HeirlineInsert = astronvim.get_hlgroup("HeirlineInsert", { fg = "#00ff00", bg = "#000000" })
  local HeirlineVisual = astronvim.get_hlgroup("HeirlineVisual", { fg = "#ff00ff", bg = "#000000" })
  local HeirlineReplace = astronvim.get_hlgroup("HeirlineReplace", { fg = "#ff0000", bg = "#000000" })
  local HeirlineCommand = astronvim.get_hlgroup("HeirlineCommand", { fg = "#ffff00", bg = "#000000" })
  local HeirlineInactive = astronvim.get_hlgroup("HeirlineInactive", { fg = "#666666", bg = "#000000" })
  local GitSignsAdd = astronvim.get_hlgroup("GitSignsAdd")
  local GitSignsChange = astronvim.get_hlgroup("GitSignsChange")
  local GitSignsDelete = astronvim.get_hlgroup("GitSignsDelete")
  local DiagnosticError = astronvim.get_hlgroup("DiagnosticError")
  local DiagnosticWarn = astronvim.get_hlgroup("DiagnosticWarn")
  local DiagnosticInfo = astronvim.get_hlgroup("DiagnosticInfo")
  local DiagnosticHint = astronvim.get_hlgroup("DiagnosticHint")
  local colors = astronvim.user_plugin_opts("heirline.colors", {
    fg = StatusLine.fg,
    bg = StatusLine.bg,
    cwd_bg = CursorLine.bg,
    section_fg = StatusLine.fg,
    section_bg = StatusLine.bg,
    normal_fg = Normal.fg,
    git_branch_fg = Conditional.fg,
    dir_fg = TypeDef.fg,
    ts_fg = String.fg,
    search_fg = Search.fg,
    search_bg = Search.bg,
    git_added = GitSignsAdd.fg,
    git_changed = GitSignsChange.fg,
    git_removed = GitSignsDelete.fg,
    diag_ERROR = DiagnosticError.fg,
    diag_WARN = DiagnosticWarn.fg,
    diag_INFO = DiagnosticInfo.fg,
    diag_HINT = DiagnosticHint.fg,
    normal = astronvim.status.hl.lualine_mode("normal", HeirlineNormal.fg),
    insert = astronvim.status.hl.lualine_mode("insert", HeirlineInsert.fg),
    visual = astronvim.status.hl.lualine_mode("visual", HeirlineVisual.fg),
    replace = astronvim.status.hl.lualine_mode("replace", HeirlineReplace.fg),
    command = astronvim.status.hl.lualine_mode("command", HeirlineCommand.fg),
    inactive = HeirlineInactive.fg,
  })

  for _, section in ipairs { "git_branch", "file_info", "git_diff", "diagnostics", "lsp", "ts", "nav" } do
    if not colors[section .. "_bg"] then colors[section .. "_bg"] = colors["section_bg"] end
    if not colors[section .. "_fg"] then colors[section .. "_fg"] = colors["section_fg"] end
  end
  return colors
end

return { setup_colors = setup_colors }
