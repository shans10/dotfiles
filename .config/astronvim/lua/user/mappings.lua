local is_available = astronvim.is_available

local maps = { i = {}, n = {}, t = {}, v = {}, x = {} }

--- NORMAL MODE ---
--
-- Disable default keybindings
maps.n["<leader>o"] = false
maps.n["<leader>fb"] = false
maps.n["<leader>fh"] = false
maps.n["<leader>fm"] = false
maps.n["<leader>fo"] = false

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
maps.n["<leader>ba"] = { "<cmd>silent! %bd|e#|bd#<cr>", desc = "Close all but current buffer" }
maps.n["<leader>bd"] = { function() astronvim.close_buf(0) end, desc = "Delete buffer" }
maps.n["<leader>bD"] = { function() astronvim.close_buf(0, true) end, desc = "Force delete buffer" }
maps.n["<leader>bl"] = { "<C-6>", desc = "Last buffer" }
maps.n["<leader>bn"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
maps.n["<leader>bp"] = { "<cmd>bprev<cr>", desc = "Previous buffer" }

-- Heirline bufferline
if vim.g.heirline_bufferline then
  maps.n["<A-.>"] = { function() astronvim.move_buf(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Move buffer tab right" }
  maps.n["<A-,>"] = { function() astronvim.move_buf(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Move buffer tab left" }
  maps.n["<leader>bs"] = {
    function()
      astronvim.status.heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    end,
    desc = "Select buffer from tabline",
  }
  maps.n["<leader>bt"] = {
    function()
      astronvim.status.heirline.buffer_picker(function(bufnr) astronvim.close_buf(bufnr) end)
    end,
    desc = "Delete buffer from tabline",
  }
end

-- Bufferline
if is_available "bufferline.nvim" then
  -- Close/pick buffers
  maps.n["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and close buffer" }
  maps.n["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick and jump to buffer" }
  maps.n["<leader>b["] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffers" }
  maps.n["<leader>b]"] = { "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffers" }
  -- Navigate buffers
  maps.n["<A-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" }
  maps.n["<A-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" }
  maps.n["<leader>b>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" }
  maps.n["<leader>b<"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" }
end

-- File Standalone Keybindings
maps.n["<leader>f."] = { function() require("telescope.builtin").grep_string() end, desc = "Search word under cursor" }
maps.n["<leader>fa"] = { "ggVG", desc = "Select all" }
maps.n["<leader>fc"] = { function() astronvim.close_buf(0) end, desc = "Close" }
maps.n["<leader>fC"] = { function() astronvim.close_buf(0, true) end, desc = "Force close" }
maps.n["<leader>fi"] = { "gg=G", desc = "Indent all" }
maps.n["<leader>fs"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>ft"] = { "<cmd>%s/\\s\\+$//e | noh<cr>", desc = "Remove trailing whitespaces" }
if is_available("suda.vim") then
  maps.n["<leader>fS"] = { "<cmd>SudaWrite<cr>", desc = "Save as root" }
end

-- Telescope
if is_available "telescope.nvim" then
  -- Buffer
  maps.n["<leader>,"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" }
  maps.n["<leader>bb"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" }

  -- File
  maps.n["<leader>fb"] = { function() require("telescope").extensions.file_browser.file_browser() end,
    desc = "Telecope file browser" }
  maps.n["<leader>fd"] = { "<cmd>Telescope find_files cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>",
    desc = "Find files in CWD" }
  maps.n["<leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "Recently opened files" }

  -- LSP
  maps.n["<leader>ld"] = { function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
    desc = "Show document diagnostics" }
  maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Show workspace diagnostics" }
  maps.n["<leader>le"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Show definition" }

  -- Search
  maps.n["<leader>sm"] = { function() require("telescope.builtin").marks() end, desc = "Search bookmarks" }
  maps.n["<leader>sM"] = { function() require("telescope.builtin").man_pages() end, desc = "Search man" }
  maps.n["<leader>sp"] = { function() require("telescope").extensions.project.project() end, desc = "Search projects" }
end

-- UI
maps.n["<leader>uA"] = { function() astronvim.ui.toggle_autoformat() end, desc = "Toggle autoformatting" }

-- Move line/char up/down or left/right (move.nvim plugin)
if is_available("move.nvim") then
  maps.n["<A-j>"] = { "<cmd>MoveLine(1)<cr>", desc = "Move line down" }
  maps.n["<A-k>"] = { "<cmd>MoveLine(-1)<cr>", desc = "Move line up" }
  maps.n["<A-h>"] = { "<cmd>MoveHChar(-1)<cr>", desc = "Move line down" }
  maps.n["<A-l>"] = { "<cmd>MoveHChar(1)<cr>", desc = "Move line up" }
end

--- INSERT MODE ---
--
-- Move line up or down
maps.i["<A-j>"] = { "<Esc><cmd>MoveLine(1)<cr>gi", desc = "Move line down" }
maps.i["<A-k>"] = { "<Esc><cmd>MoveLine(-1)<cr>gi", desc = "Move line up" }

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

-- Move selected block up/down or left/right (move.nvim plugin)
if is_available("move.nvim") then
  maps.v["<A-j>"] = { ":MoveBlock(1)<cr>", desc = "Move selected block down" }
  maps.v["<A-k>"] = { ":MoveBlock(-1)<cr>", desc = "Move selected block up" }
  maps.v["<A-h>"] = { ":MoveHBlock(-1)<cr>", desc = "Move selected block down" }
  maps.v["<A-l>"] = { ":MoveHBlock(1)<cr>", desc = "Move selected block up" }
end

-- Better increment/decrement
maps.x["+"] = { "g<C-a>", desc = "Increment number" }
maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

return maps
