local mappings = {
  n = {
    --- STANDARD LEADER KEY OPERATIONS ---
    --
    ["<leader>o"] = false,
    ["<leader>."] = { function() require("telescope").extensions.file_browser.file_browser() end, desc = "File browser" },
    ["<leader>W"] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD to file" },

    -- Navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },

    -- Better search
    n = { require("user.utils").better_search "n", desc = "Next search" },
    N = { require("user.utils").better_search "N", desc = "Previous search" },

    -- Better increment/decrement
    ["-"] = { "<c-x>", desc = "Descrement number" },
    ["+"] = { "<c-a>", desc = "Increment number" },

    --- FILE EXPLORER ---
    --
    -- Neo-tree
    ["<C-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle nvim-tree" },

    --- TERMINAL ---
    --
    -- External terminal
    ["<leader>tt"] = { "<cmd>!alacritty<cr><cr>", desc = "Open alacritty in cwd" },

    -- ToggleTerm
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    --- BUFFER ---
    --
    -- Buffer Standalone Keybindings
    ["<leader>ba"] = { "<cmd>silent! %bd|e#|bd#<cr>", desc = "Close all but current buffer" },
    ["<leader>bd"] = { "<cmd>Bdelete<cr>", desc = "Delete buffer" },
    ["<leader>bD"] = { "<cmd>Bdelete!<cr>", desc = "Force delete buffer" },
    ["<leader>bl"] = { "<C-6>", desc = "Last buffer" },

    -- Heirline bufferline
    ["<A-.>"] = { function() astronvim.move_buf(vim.v.count > 0 and vim.v.count or 1) end, desc = "Move buffer tab right" },
    ["<A-,>"] = { function() astronvim.move_buf(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Move buffer tab left" },
    ["<leader>bn"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
    ["<leader>bp"] = { "<cmd>bprev<cr>", desc = "Previous buffer" },
    -- ["<leader>bs"] = {
    --   function()
    --     astronvim.status.heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    --   end,
    --   desc = "Select buffer from tabline",
    -- },
    -- ["<leader>bt"] = {
    --   function()
    --     astronvim.status.heirline.buffer_picker(function(bufnr) astronvim.close_buf(bufnr) end)
    --   end,
    --   desc = "Delete buffer from tabline",
    -- },

    -- -- Bufferline
    -- -- Close/pick buffers
    -- ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and close buffer" },
    -- ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick and jump to buffer" },
    -- ["<leader>b["] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffers" },
    -- ["<leader>b]"] = { "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffers" },
    -- -- Navigate buffers
    -- ["<A-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
    -- ["<A-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },
    -- ["<leader>b>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
    -- ["<leader>b<"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },

    -- Telescope
    ["<leader>,"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" },
    ["<leader>bb"] = { function() require("telescope.builtin").buffers() end, desc = "Switch buffer" },

    --- FILE ---
    --
    -- Disable default keybindings
    -- ["<leader>fb"] = false,
    ["<leader>fh"] = false,
    ["<leader>fm"] = false,
    ["<leader>fo"] = false,

    -- File Standalone Keybindings
    ["<leader>f."] = { function() require("telescope.builtin").grep_string() end, desc = "Search word under cursor" },
    ["<leader>fa"] = { "ggVG", desc = "Select all" },
    ["<leader>fi"] = { "gg=G", desc = "Indent all" },
    ["<leader>fp"] = { "1<C-g>", desc = "Show full path" },
    ["<leader>fs"] = { "<cmd>w<cr>", desc = "Save" },
    ["<leader>ft"] = { "<cmd>%s/\\s\\+$//e | noh<cr>", desc = "Remove trailing whitespaces" },
    ["<leader>fS"] = { "<cmd>SudaWrite<cr>", desc = "Save as root" },

    -- Bufdelete
    ["<leader>fc"] = { "<cmd>Bdelete<cr>", desc = "Close" },
    ["<leader>fC"] = { "<cmd>Bdelete!<cr>", desc = "Close unsaved" },

    -- Telescope
    ["<leader>fb"] = { function() require("telescope").extensions.file_browser.file_browser() end,
      desc = "Telecope file browser" },
    ["<leader>fd"] = { "<cmd>Telescope find_files cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>",
      desc = "Find files in CWD" },
    ["<leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "Recently opened files" },

    --- LSP ---
    --
    ["<leader>ld"] = { function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
      desc = "Show document diagnostics" },
    ["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Show workspace diagnostics" },
    -- ["<leader>le"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Show definition" },

    --- SEARCH ---
    --
    ["<leader>sm"] = { function() require("telescope.builtin").marks() end, desc = "Search bookmarks" },
    ["<leader>sM"] = { function() require("telescope.builtin").man_pages() end, desc = "Search man" },
    ["<leader>sp"] = { function() require("telescope").extensions.project.project() end, desc = "Search projects" },

    --- UI ---
    --
    ["<leader>uA"] = { function() astronvim.ui.toggle_autoformat() end, desc = "Toggle autoformatting" },

    -- Move line/char up/down or left/right
    ["<A-j>"] = { "<cmd>MoveLine(1)<cr>", desc = "Move line down" },
    ["<A-k>"] = { "<cmd>MoveLine(-1)<cr>", desc = "Move line up" },
    ["<A-h>"] = { "<cmd>MoveHChar(-1)<cr>", desc = "Move line down" },
    ["<A-l>"] = { "<cmd>MoveHChar(1)<cr>", desc = "Move line up" },
  },
  i = {
    -- Move line up or down
    ["<A-j>"] = { "<Esc><cmd>MoveLine(1)<cr>gi", desc = "Move line down" },
    ["<A-k>"] = { "<Esc><cmd>MoveLine(-1)<cr>gi", desc = "Move line up" },

    -- Save File
    ["<C-s>"] = { "<Esc><cmd>w<cr>", desc = "Save file" },

    -- ToggleTerm
    ["<C-\\>"] = { "<Esc><cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  t = {
    -- ToggleTerm
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<C-q>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
  },
  v = {
    -- Navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },

    -- Move selected block up/down or left/right
    ["<A-j>"] = { ":MoveBlock(1)<cr>", desc = "Move selected block down" },
    ["<A-k>"] = { ":MoveBlock(-1)<cr>", desc = "Move selected block up" },
    ["<A-h>"] = { ":MoveHBlock(-1)<cr>", desc = "Move selected block down" },
    ["<A-l>"] = { ":MoveHBlock(1)<cr>", desc = "Move selected block up" },
  },
  x = {
    -- Better increment/decrement
    ["+"] = { "g<C-a>", desc = "Increment number" },
    ["-"] = { "g<C-x>", desc = "Descrement number" },
  }
}

return mappings
