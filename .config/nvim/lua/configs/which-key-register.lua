local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  local is_available = doomnvim.is_available
  local user_plugin_opts = doomnvim.user_plugin_opts
  local mappings = {
    n = {
      ["<leader>"] = {
        f = { name = "File" },
        p = { name = "Packer" },
        l = { name = "LSP" },
      },
    },
  }

  local extra_sections = {
    b = "Buffer",
    g = "Git",
    s = "Search",
    S = "Session",
    t = "Terminal",
  }

    local function init_table(mode, prefix, idx)
    if not mappings[mode][prefix][idx] then
      mappings[mode][prefix][idx] = { name = extra_sections[idx] }
    end
  end

  -- Buffer
  if is_available "bufferline.nvim" then
    init_table("n", "<leader>", "b")
  end

  -- SessionManager
  if is_available "neovim-session-manager" then
    -- Session
    init_table("n", "<leader>", "S")

    -- Search
    init_table("n", "<leader>", "s")
  end

  -- Bufdelete
  if is_available "bufdelete.nvim" then

    -- File
    init_table("n", "<leader>", "f")

    -- Buffer
    init_table("n", "<leader>", "b")
  end

  -- GitSigns
  if is_available "gitsigns.nvim" then
    init_table("n", "<leader>", "g")
  end

  -- ToggleTerm
  if is_available "nvim-toggleterm.lua" then
    -- Git
    init_table("n", "<leader>", "g")

    -- Terminal
    init_table("n", "<leader>", "t")
  end

  -- Telescope
  if is_available "telescope.nvim" then
    -- Buffer
    init_table("n", "<leader>", "b")

    -- Git
    init_table("n", "<leader>", "g")

    -- Search
    init_table("n", "<leader>", "s")
  end

  mappings = user_plugin_opts("which-key.register_mappings", mappings)
  -- support previous legacy notation, deprecate at some point
  mappings.n["<leader>"] = user_plugin_opts("which-key.register_n_leader", mappings.n["<leader>"])
  for mode, prefixes in pairs(mappings) do
    for prefix, mapping_table in pairs(prefixes) do
      which_key.register(mapping_table, {
        mode = mode,
        prefix = prefix,
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
    end
  end
end
