local M = {}

function M.config()
  local status_ok, npairs = pcall(require, "nvim-autopairs")
  if status_ok then
    npairs.setup(doomnvim.user_plugin_opts("plugins.nvim-autopairs", {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    }))

    local rules = doomnvim.user_plugin_opts("nvim-autopairs").add_rules
    if vim.tbl_contains({ "function", "table" }, type(rules)) then
      npairs.add_rules(type(rules) == "function" and rules(npairs) or rules)
    end

    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } })
    end

    -- Add spaces between parentheses
    local Rule = require'nvim-autopairs.rule'
    local cond = require'nvim-autopairs.conds'

    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col -1, opts.col)
          return vim.tbl_contains({ '()', '{}', '[]' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
        end),
      Rule('', ' )')
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == ')' end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(')'),
      Rule('', ' }')
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == '}' end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key('}'),
      Rule('', ' ]')
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == ']' end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(']'),
    }
  end
end

return M
