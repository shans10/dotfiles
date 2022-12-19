local mappings = {
  n = {
    --- STANDARD LEADER KEY OPERATIONS ---
    --
    ["<leader>o"] = false,
    ["<leader>."] = { function() require("telescope").extensions.file_browser.file_browser() end, desc = "File browser" },
    ["<leader>C"] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD to file" },

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
    ["<leader>bl"] = { "<C-6>", desc = "Last buffer" },

    -- Bufdelete
    ["<leader>c"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Close buffer" },
    ["<leader>bd"] = { "<cmd>Bdelete<cr>", desc = "Delete" },
    ["<leader>bD"] = { "<cmd>Bdelete!<cr>", desc = "Delete unsaved" },

    -- Bufferline
    -- Close/pick buffers
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and close buffer" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick and jump to buffer" },
    ["<leader>b["] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffers" },
    ["<leader>b]"] = { "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffers" },
    -- Navigate buffers
    ["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
    ["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" },
    ["<A-.>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
    ["<A-,>"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },
    ["<leader>bn"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
    ["<leader>bp"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" },
    ["<leader>b>"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" },
    ["<leader>b<"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" },

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
    ["<leader>ln"] = { "<cmd>NullLsInfo<cr>", desc = "Null-Ls information" },

    --- SEARCH ---
    --
    ["<leader>sm"] = { function() require("telescope.builtin").marks() end, desc = "Search bookmarks" },
    ["<leader>sM"] = { function() require("telescope.builtin").man_pages() end, desc = "Search man" },
    ["<leader>sp"] = { function() require("telescope").extensions.project.project() end, desc = "Search projects" },

    --- UI ---
    --
    ["<leader>uA"] = { function() astronvim.ui.toggle_autoformat() end, desc = "Toggle autoformatting" },

    -- Move lines up and down
    ["<A-j>"] = { "<cmd>m .+1<cr>==", desc = "Move line down" },
    ["<A-k>"] = { "<cmd>m .-2<cr>==", desc = "Move line up" },

    -- Clear search highlight
    ["<Esc>"] = { "<cmd>noh<cr>", desc = "Clear search highlight with esc" },
  },
  i = {
    -- Move line up and down
    ["<A-j>"] = { "<Esc><cmd>m .+1<cr>==gi", desc = "Move line down" },
    ["<A-k>"] = { "<Esc><cmd>m .-2<cr>==gi", desc = "Move line up" },

    -- Save File
    ["<C-s>"] = { "<Esc><cmd>w<cr>", desc = "Save file" },

    -- ToggleTerm
    ["<C-\\>"] = { "<Esc><cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  t = {
    -- ToggleTerm
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}

return mappings
