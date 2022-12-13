local st = require "user.plugins.heirline.status"
local component = {}

-- Define heirline components
component.left_bar = {
  hl = { fg = "normal" },
  st.utils.surround(st.env.separators.left, "bg", { provider = astronvim.get_icon("BarBold") }),
}

component.mode = {
  hl = st.hl.mode,
  st.utils.surround(st.env.separators.left, "bg", { provider = astronvim.get_icon("EvilIcon") }),
}

component.search = {
  condition = st.condition.search,
  hl = { fg = "search_fg" },
  st.utils.surround(st.env.separators.left, "search_bg", {
    provider = st.provider.search()
  }),
}

component.fill = { provider = st.provider.fill() }

component.nav = {
  hl = { fg = "nav_fg" },
  st.utils.surround(st.env.separators.left, "nav_bg", {
    { provider = st.provider.ruler },
    { provider = st.provider.percentage { padding = { left = 1 } } },
  }),
}

component.file_path = {
  init = st.init.file_path,
  condition = st.condition.has_filetype,
  hl = { fg = "file_info_fg", bold = true },
  st.utils.surround(st.env.separators.left, "file_info_bg", {
    { provider = st.provider.file_size { padding = { left = 1, right = 2 } }, hl = { bold = false } },
    { provider = st.provider.file_icon { padding = { right = 1 } }, hl = st.hl.filetype_color },
    { provider = st.provider.file_modified { padding = { left = 1 ,right = 1 } }, hl = { fg = "diag_ERROR" } },
    {
      flexible = 1,
      {
        provider = st.provider.work_dir(),
        hl = function()
          if vim.bo.modified then
            return { fg = "diag_ERROR" }
          else
            return { fg = "dir_fg" }
          end
        end
      },
      { provider = "" }
    },
    {
      flexible = 1,
      {
        provider = st.provider.current_path(),
        hl = function()
          if vim.bo.modified then
            return { fg = "diag_ERROR" }
          else
            return { fg = "visual" }
          end
        end
      },
      { provider = "" }
    },
    {
      provider = st.provider.filename { padding = { right = 1 } },
      hl = function()
        if vim.bo.modified then
          return { fg = "diag_ERROR" }
        end
      end
    },
    { provider = st.provider.file_read_only(), hl = { fg = "diag_WARN" } },
    { provider = "%<" }
  }),
}

component.filetype = {
  condition = st.condition.has_filetype,
  hl = { fg = "dir_fg" },
  st.utils.surround(st.env.separators.right, "file_info_bg", {
    provider = st.provider.filetype(),
    hl = { bold = true },
  }),
}

component.git_branch = {
  condition = st.condition.is_git_repo,
  hl = { fg = "git_branch_fg" },
  st.utils.surround(st.env.separators.right, "git_branch_bg", {
    provider = st.provider.git_branch(),
    hl = { bold = true },
  }),
  on_click = {
    name = "heirline_branch",
    callback = function()
      if astronvim.is_available "telescope.nvim" then
        vim.defer_fn(function() require("telescope.builtin").git_branches() end, 100)
      end
    end,
  },
}

component.git_changes = {
  condition = st.condition.git_changed,
  hl = { fg = "diag_WARN", bold = true },
  provider = function()
    local git_status = vim.b.gitsigns_status_dict
    return git_status.added + git_status.removed + git_status.changed .. astronvim.get_icon("Change")
  end,
  on_click = {
    name = "heirline_git",
    callback = function()
      if astronvim.is_available "telescope.nvim" then
        vim.defer_fn(function() require("telescope.builtin").git_status() end, 100)
      end
    end,
  },
}

component.diagnostics = {
  condition = st.condition.has_diagnostics,
  hl = { fg = "diagnostics_fg" },
  st.utils.surround(st.env.separators.right, "diagnostics_bg", {
    {
      provider = st.provider.diagnostics {
        severity = "ERROR",
        icon = { kind = "DiagnosticError", padding = { left = 1, right = 1 } },
      },
      hl = { fg = "diag_ERROR" },
    },
    {
      provider = st.provider.diagnostics {
        severity = "WARN",
        icon = { kind = "DiagnosticWarn", padding = { left = 1, right = 1 } },
      },
      hl = { fg = "diag_WARN" },
    },
    {
      provider = st.provider.diagnostics {
        severity = "INFO",
        icon = { kind = "DiagnosticInfo", padding = { left = 1, right = 1 } },
      },
      hl = { fg = "diag_INFO" },
    },
    {
      provider = st.provider.diagnostics {
        severity = "HINT",
        icon = { kind = "DiagnosticHint", padding = { left = 1, right = 1 } },
      },
      hl = { fg = "diag_HINT" },
    },
  }),
  on_click = {
    name = "heirline_diagnostic",
    callback = function()
      if astronvim.is_available "telescope.nvim" then
        vim.defer_fn(function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, 100)
      end
    end,
  },
}

component.lsp_status = {
  condition = st.condition.lsp_attached,
  hl = { fg = "lsp_fg" },
  st.utils.surround(st.env.separators.right, "lsp_bg", {
    {
      flexible = 3,
      { provider = st.provider.lsp_progress { padding = { right = 1 } } },
      { provider = "" }
    },
    { provider = astronvim.pad_string(astronvim.get_icon("ActiveLSP1"), { right = 1 }), hl = { fg = "treesitter_fg" } },
  }),
  on_click = {
    name = "heirline_lsp",
    callback = function()
      vim.defer_fn(function() vim.cmd "LspInfo" end, 100)
    end,
  },
}

component.treesitter = {
  condition = st.condition.treesitter_available,
  hl = { fg = "treesitter_fg" },
  st.utils.surround(st.env.separators.right, "treesitter_bg", {
    provider = st.provider.str { str = "TS", icon = { kind = "ActiveTS" } },
    hl = { bold = true }
  }),
}

component.special_dir = {
  hl = { fg = "treesitter_fg", bold = true },
  provider = function(self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":t")
    return astronvim.pad_string(astronvim.get_icon("Directory"), { right = 1 }) .. self.cwd
  end,
}

component.special_ft = {
  condition = function()
    return vim.bo.filetype and vim.bo.filetype ~= ""
  end,
  hl = { fg = "dir_fg", bold = true },
  provider = st.provider.filetype(),
}

-- Create statuslines
local statusline = {
  fallthrough = false,
  -- Default statusline
  {
    hl = { fg = "fg", bg = "bg" },
    condition = st.condition.is_valid_file,
    component.left_bar,
    component.mode,
    component.search,
    component.file_path,
    component.nav,
    component.fill,
    component.diagnostics,
    component.lsp_status,
    component.treesitter,
    component.filetype,
    component.git_branch,
    component.git_changes
  },
  -- For special filetypes/buftypes
  {
    hl = { fg = "fg", bg = "bg" },
    component.left_bar,
    component.special_ft,
    component.fill,
    component.special_dir
  },
}

return statusline
