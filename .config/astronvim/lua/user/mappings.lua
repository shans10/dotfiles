local is_available = require "astronvim.utils".is_available

local maps = { i = {}, n = {}, t = {}, v = {}, x = {} }

--- NORMAL MODE ---
--
-- Disable default keybindings
maps.n["<leader>o"] = false
maps.n["<leader>b|"] = false
maps.n["<leader>b\\"] = false
maps.n["<leader>bb"] = false

-- Standard leader-key operations
maps.n["<leader>."] = { function() require("telescope").extensions.file_browser.file_browser() end, desc = "File browser" }
maps.n["<leader>W"] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD to file" }

-- Navigating wrapped lines
maps.n["j"] = { "gj", desc = "Navigate down" }
maps.n["k"] = { "gk", desc = "Navigate down" }

-- Better search
maps.n["n"] = { require("user.utils").better_search "n", desc = "Next search" }
maps.n["N"] = { require("user.utils").better_search "N", desc = "Previous search" }

-- Better increment/decrement
maps.n["-"] = { "<c-x>", desc = "Descrement number" }
maps.n["+"] = { "<c-a>", desc = "Increment number" }

-- Neo-tree
if is_available "neo-tree.nvim" then
  maps.n["<C-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle nvim-tree" }
end

-- External terminal
maps.n["<leader>tt"] = { "<cmd>!alacritty<cr><cr>", desc = "Open alacritty in cwd" }

-- ToggleTerm
maps.n["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }

-- Buffer Standalone Keybindings
maps.n["<S-l>"] = {
  function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Next buffer"
}
maps.n["<S-h>"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Previous buffer"
}
maps.n["<leader>ba"] = { "ggVG", desc = "Select all" }
maps.n["<leader>bd"] = { function() require("astronvim.utils.buffer").close() end, desc = "Delete buffer" }
maps.n["<leader>bD"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force delete buffer" }
maps.n["<leader>bi"] = { "gg=G", desc = "Indent all" }
maps.n["<leader>bl"] = { "<cmd>b#<cr>", desc = "Last buffer" }
maps.n["<leader>bn"] = {
  function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Next buffer"
}
maps.n["<leader>bp"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Previous buffer"
}
maps.n["<leader>bs"] = { "<cmd>w<cr>", desc = "Save buffer" }
maps.n["<leader>bt"] = { "<cmd>%s/\\s\\+$//e | noh<cr>", desc = "Remove trailing whitespaces" }
if is_available("suda.vim") then
  maps.n["<leader>bS"] = { "<cmd>SudaWrite<cr>", desc = "Save buffer as root" }
end

-- Heirline bufferline
if vim.g.tabline then
  maps.n["<A-.>"] = {
    function() require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Move buffer tab right",
  }
  maps.n["<A-,>"] = {
    function() require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Move buffer tab left",
  }
  maps.n["<leader>bB"] = {
    function()
      require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    end,
    desc = "Select buffer from tabline",
  }
  maps.n["<leader>bT"] = {
    function()
      require("astronvim.utils.status").heirline.buffer_picker(
        function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
      )
    end,
    desc = "Delete buffer from tabline",
  }
  maps.n["<leader>b\\"] = {
    function()
      require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
        vim.cmd.split()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Horizontal split buffer from tabline",
  }
  maps.n["<leader>b|"] = {
    function()
      require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Vertical split buffer from tabline",
  }
end

-- Telescope
if is_available "telescope.nvim" then
  -- Buffer
  maps.n["<leader>,"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" }
  maps.n["<leader>bb"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" }
  maps.n["<Tab>"] = {
    function()
      if #vim.t.bufs > 1 then
        require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
      else
        require "astronvim.utils".notify "No other buffers open"
      end
    end,
    desc = "Switch Buffers",
  }

  -- Find
  maps.n["<leader>fd"] = {
    "<cmd>Telescope find_files cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>",
    desc = "Find files in CWD"
  }
  maps.n["<leader>fp"] = { function() require("telescope").extensions.project.project() end, desc = "Find projects" }

  -- LSP
  maps.n["<leader>ld"] = {
    function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
    desc = "Show document diagnostics"
  }
  maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Show workspace diagnostics" }
  maps.n["<leader>le"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Show definition" }
end

-- UI
maps.n["<leader>uA"] = { function() require("astronvim.utils.ui").toggle_autoformat() end, desc = "Toggle autoformatting" }

--- INSERT MODE ---
--
-- Move line up or down
maps.i["<A-j>"] = { "<Esc><cmd>m .+1<cr>gi", desc = "Move line down" }
maps.i["<A-k>"] = { "<Esc><cmd>m .-2<cr>gi", desc = "Move line up" }

-- Save File
maps.i["<C-s>"] = { "<Esc><cmd>w<cr>", desc = "Save file" }

-- ToggleTerm
maps.i["<C-\\>"] = { "<Esc><cmd>ToggleTerm<cr>", desc = "Toggle terminal" }

--- TERMINAL MODE ---
--
-- ToggleTerm
maps.t["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
maps.t["<C-q>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }
maps.t["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" }

--- VISUAL MODE ---
--
-- Navigating wrapped lines
maps.v["j"] = { "gj", desc = "Navigate down" }
maps.v["k"] = { "gk", desc = "Navigate down" }

-- Better increment/decrement
maps.x["+"] = { "g<C-a>", desc = "Increment number" }
maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

return maps
