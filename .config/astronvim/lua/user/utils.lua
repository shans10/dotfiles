M = {}

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if searched then
      pcall(vim.cmd.normal, "zzzv")
    else
      require("astronvim.utils").notify(error, "error")
    end
    vim.opt.hlsearch = searched
  end
end

return M
