local config = {

  -- Customize Heirline options
  heirline = {
    -- Customize colors for each element each element has a `_fg` and a `_bg`
    colors = function(colors)
      -- Bufferline
      colors.buffer_path_fg = astronvim.get_hlgroup("NonText").fg

      -- Winbar
      colors.winbar_fg = astronvim.get_hlgroup("NonText").fg
      colors.winbarnc_fg = astronvim.get_hlgroup("NonText").fg

      -- Set colors based on chosen heirline statusline theme
      --
      -- Get current statusline theme
      local theme = vim.g.heirline_theme

      -- Doom theme
      if theme == "doom" then
        local search = astronvim.get_hlgroup("IncSearch")
        local typedef = astronvim.get_hlgroup("TypeDef")
        colors.search_fg = search.fg
        colors.search_bg = search.bg
        colors.work_dir_fg = typedef.fg

      -- Lunarvim theme
      elseif theme == "lunarvim" then
        local constant_fg = astronvim.get_hlgroup("Constant").fg
        local cursorline_bg = astronvim.get_hlgroup("CursorLine").bg
        local normal_fg = astronvim.get_hlgroup("Normal").fg
        colors.git_branch_bg = cursorline_bg
        colors.git_branch_fg = normal_fg
        colors.git_branch_icon = constant_fg
        colors.ruler_fg = normal_fg
        colors.ruler_bg = cursorline_bg
        colors.separator_bg = cursorline_bg

      -- Nvchad theme
      elseif theme == "nvchad" then
        local comment_fg = astronvim.get_hlgroup("Comment").fg
        colors.git_branch_fg = comment_fg
        colors.git_added = comment_fg
        colors.git_changed = comment_fg
        colors.git_removed = comment_fg
        colors.blank_bg = astronvim.get_hlgroup("WildMenu").bg
        colors.file_info_bg = astronvim.get_hlgroup("Visual").bg
        colors.nav_icon_bg = astronvim.get_hlgroup("String").fg
        colors.nav_fg = colors.nav_icon_bg
        colors.folder_icon_bg = astronvim.get_hlgroup("Error").fg
      end

      return colors
    end,
    -- Customize attributes of highlighting in Heirline components
    attributes = {
      -- Bufferline
      buffer_path = { bold = true, italic = true },
    },
    -- Customize if icons should be highlighted
    icon_highlights = {
      breadcrumbs = true, -- LSP symbols in the breadcrumbs
      file_icon = {
        winbar = function() return astronvim.status.condition.is_active() end, -- filetype icon in the winbar based on winbar status
      },
    },
  },
}

return config
