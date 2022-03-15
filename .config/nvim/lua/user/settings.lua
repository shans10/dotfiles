local config = {

  -- Set colorscheme
  colorscheme = "onedark",

  -- Add plugins
  plugins = {
    { "lambdalisue/suda.vim" },
    { "farmergreg/vim-lastplace" },
    -- { "andweeb/presence.nvim" },
    -- {
    -- "ray-x/lsp_signature.nvim",
    -- event = "BufRead",
    -- config = function()
    -- require("lsp_signature").setup()
    -- end,
    -- },
  },

  overrides = {
    treesitter = {
      ensure_installed = { "lua", "rust", "go", "c", "java", "cpp", "fish" },
    },
  },

  -- Diagnostics option
  diagnostics = {
    enable = true,
    text = "none",
  },

  -- Disable default plugins
  enabled = {
    bufferline = true,
    nvim_tree = true,
    lualine = true,
    lspsaga = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  packer_file = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",

  polish = function()
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    local set = vim.opt

    --- SET OPTIONS ---
    set.relativenumber = true

    --- SET KEYBINDINGS ---
    --
    -- Force write
    map("n", "<C-s>", "<cmd>w!<CR>", opts)

    -- Save in insert mode
    map("i", "<C-s>", "<Esc><cmd>w<CR>", opts)

    -- Files
    map("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", opts)
    map("n", "<leader>fs", "<cmd>w<CR>", opts)
    map("n", "<leader>fc", "<cmd>bd<CR>", opts)
    map("n", "<leader>fC", "<cmd>bd!<CR>", opts)
    map("n", "<leader>fi", "gg=G<CR>", opts)
    map("n", "<leader>fS", "ggVG<CR>", opts)
    map("n", "<leader>fr", "<cmd>e<CR>", opts)
    map("n", "<leader>fR", "<cmd>e!<CR>", opts)
    map("n", "<leader>fp", "1<C-g><CR>", opts)

    -- Buffers
    map("n", "<leader>bn", "<cmd>bn<CR>", opts)
    map("n", "<leader>bp", "<cmd>bp<CR>", opts)
    map("n", "<leader>bd", "<cmd>bd<CR>", opts)
    map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", opts)
    map("n", "<leader>bj", "<cmd>BufferLinePick<CR>", opts)
    map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)

    -- Search
    map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", opts)
    map("n", "<leader>sw", "<cmd>Telescope live_grep<CR>", opts)
    map("n", "<leader>sf", "<cmd>FZF<CR>", opts)

    -- LSP
    map("n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts)
    map("n", "<leader>lD", "<cmd>Telescope lsp_definitions<CR>", opts)
    map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts)
    map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts)

    -- Move lines up/down
    map("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
    map("n", "<A-k>", "<cmd>m .-2<CR>==", opts)
    map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
    map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

    -- Clear search highlight
    map("n", "<Esc>", "<cmd>noh<CR>", opts)

    --- SET AUTOCOMMANDS ---
    --
    -- Automatically run PackerSync on plugins.lua file change
    vim.cmd [[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end
    ]]

    -- Disable tabline in dashboard buffer
    vim.cmd[[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]
  end,
}

-- Vim suda plugin settings
vim.g.suda_smart_edit = 1

return config
