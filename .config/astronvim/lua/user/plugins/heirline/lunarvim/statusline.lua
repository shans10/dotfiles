local component = {}
local separator = astronvim.get_icon("Bar")
local st = require "user.plugins.heirline.status"

component.cwd = {
  hl = { fg = "normal_fg", bg = "cwd_bg" },
  { provider = astronvim.pad_string(astronvim.get_icon("Directory"), { left = 1, right = 1 }), hl = { fg = "command" } },
  {
    provider = function(self)
      local cwd = vim.fn.getcwd(0)
      self.cwd = vim.fn.fnamemodify(cwd, ":t")
      return st.utils.stylize(self.cwd, { padding = { right = 1 } })
    end,
  },
}

component.diagnostics = {
  condition = st.condition.has_diagnostics,
  hl = { fg = "fg" },
  st.utils.surround(st.env.separators.left, "bg", {
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

component.file_info = {
  hl = { fg = "fg", bg = "bg" },
  condition = st.condition.is_valid_file,
  { provider = st.provider.filename { padding = { left = 1, right = 1 } } },
  {
    condition = function(self)
      local buffer = vim.bo[self and self.bufnr or 0]
      return buffer.modified
    end,
    provider = st.provider.str { str = "[+]", padding = { right = 1 } }
  },
  {
    condition = function(self)
      local buffer = vim.bo[self and self.bufnr or 0]
      return not buffer.modifiable or buffer.readonly
    end,
    provider = st.provider.str { str = "[-]", padding = { right = 1 } }
  },
  { provider = "%<" }
}

component.file_type = {
  hl = { fg = "fg", bg = "bg" },
  condition = function()
    return vim.bo.filetype and vim.bo.filetype ~= ""
  end,
  { provider = astronvim.pad_string(separator, { right = 1 }), hl = { fg = "cwd_bg" } },
  {
    fallthrough = false,
    {
      condition = st.condition.is_valid_file,
      provider = st.provider.file_icon { padding = { right = 1 } },
      hl = st.hl.filetype_color
    },
    { provider = astronvim.pad_string(astronvim.get_icon("DefaultFile1"), { right = 1 }) }
  },
  {
    provider = function(self)
      local buffer = vim.bo[self and self.bufnr or 0]
      return astronvim.status.utils.stylize(buffer.filetype, {
        padding = { right = 1 }
      })
    end
  },
}

component.fill = { provider = st.provider.fill() }

component.git_branch = {
  condition = st.condition.is_git_repo,
  hl = { fg = "fg", bg = "bg" },
  -- { provider = astronvim.pad_string(separator, { right = 0 }), hl = { fg = "cwd_bg" } },
  {
    provider = astronvim.pad_string(astronvim.get_icon("GitBranch"), { left = 1, right = 1 }),
    hl = { fg = "git_branch_fg", bg = "bg" },
  },
  {
    provider = function(self)
      local branch = vim.b[self and self.bufnr or 0].gitsigns_head
      local max_width = math.floor(astronvim.status.utils.width() * 0.09)
      if #branch > max_width then branch = string.sub(branch, 0, max_width) .. "…" end
      return st.utils.stylize(branch, { padding = { right = 1 } })
    end,
  },
  on_click = {
    name = "heirline_branch",
    callback = function()
      if astronvim.is_available "telescope.nvim" then
        vim.defer_fn(function() require("telescope.builtin").git_branches() end, 100)
      end
    end,
  },
}

component.git_diff = {
  condition = astronvim.status.condition.git_changed,
  {
    provider = astronvim.status.provider.git_diff {
      type = "added",
      icon = { kind = "GitAdd", padding = { left = 1, right = 1 } },
    },
    hl = { fg = "git_added" },
  },
  {
    provider = astronvim.status.provider.git_diff {
      type = "changed",
      icon = { kind = "GitChange", padding = { left = 1, right = 1 } },
    },
    hl = { fg = "git_changed" },
  },
  {
    provider = astronvim.status.provider.git_diff {
      type = "removed",
      icon = { kind = "GitDelete", padding = { left = 1, right = 1 } },
    },
    hl = { fg = "git_removed" },
  },
  on_click = {
    name = "heirline_git",
    callback = function()
      if astronvim.is_available "telescope.nvim" then
        vim.defer_fn(function() require("telescope.builtin").git_status() end, 100)
      end
    end,
  },
}

component.lsp_status = {
  fallthrough = false,
  hl = { bold = true },
  {
    condition = st.condition.lsp_attached,
    {
      flexible = 1,
      {
        provider = function(self)
          local truncate = 0.25
          local buf_client_names = {}
          for _, client in pairs(vim.lsp.get_active_clients { bufnr = self and self.bufnr or 0 }) do
            if client.name == "null-ls" then
              local null_ls_sources = {}
              for _, type in ipairs { "FORMATTING", "DIAGNOSTICS" } do
                for _, source in ipairs(astronvim.null_ls_sources(vim.bo.filetype, type)) do
                  null_ls_sources[source] = true
                end
              end
              vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
            else
              table.insert(buf_client_names, client.name)
            end
          end
          local str = table.concat(buf_client_names, ", ")
          local max_width = math.floor(astronvim.status.utils.width() * truncate)
          if #str > max_width then str = string.sub(str, 0, max_width) .. "…" end
          return st.provider.str { str = "[" .. str .. "]", padding = { right = 1 } }
        end,
      },
      { provider = st.provider.str { str = "[LS]", padding = { right = 1 } } }
    },
  },
  { provider = st.provider.str { str = "No LS", padding = { right = 1 } } },
  on_click = {
    name = "heirline_lsp",
    callback = function()
      vim.defer_fn(function() vim.cmd "LspInfo" end, 100)
    end,
  },
}

component.lsp_progress = {
  {
    flexible = 1,
    {
      condition = function() return vim.bo.filetype ~= "haskell" end,
      provider = st.provider.lsp_progress { padding = { right = 1 } }
    },
    { provider = "" }
  },
}

component.mode = {
  hl = { fg = "bg" },
  {
    provider = astronvim.pad_string(astronvim.get_icon("Target"), { left = 1, right = 1 }),
    hl = function()
      local mode_bg = st.env.modes[vim.fn.mode()][2]
      return { bg = mode_bg }
    end
  },
  -- {
  --   provider = function() return astronvim.pad_string(st.env.modes[vim.fn.mode()][1], { left = 1, right = 1 }) end,
  --   hl = function()
  --     local mode_bg = st.env.modes[vim.fn.mode()][2]
  --     return { bg = mode_bg, bold = true }
  --   end
  -- },
}

component.nav = {
  {
    provider = st.provider.ruler { padding = { left = 1, right = 1 } },
    hl = { fg = "normal_fg", bg = "cwd_bg" }
  },
  {
    provider = st.provider.str { str = "%P/%L", padding = { left = 1, right = 1 } },
    -- provider = st.provider.percentage { padding = { left = 1, right = 1 } },
    hl = function()
      local mode_bg = st.env.modes[vim.fn.mode()][2]
      return { fg = "bg", bg = mode_bg }
    end
  },
}

component.spaces = {
  { provider = astronvim.pad_string(separator, { right = 1 }), hl = { fg = "cwd_bg" } },
  {
    provider = function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return st.utils.stylize(
        astronvim.pad_string(astronvim.get_icon("Space"), { right = 1 }) .. shiftwidth, { padding = { right = 1 } }
      )
    end,
  }
}

component.ts = {
  condition = st.condition.treesitter_available,
  hl = { fg = "ts_fg" },
  provider = astronvim.pad_string(astronvim.get_icon("ActiveTS1"), { right = 2 }),
}

local statusline = {
  hl = { fg = "fg", bg = "bg" },
  component.mode,
  component.cwd,
  component.git_branch,
  component.git_diff,
  component.fill,
  component.lsp_progress,
  component.diagnostics,
  component.ts,
  component.lsp_status,
  component.spaces,
  component.file_type,
  component.nav,
}

return statusline
