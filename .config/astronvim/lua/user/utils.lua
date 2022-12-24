M = {}

function M.better_search(key)
  return function()
    local searched, error =
    pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if searched then
      pcall(vim.cmd.normal, "zzzv")
    else
      M.quick_notification(error, "error")
    end
    vim.opt.hlsearch = searched ~= nil
  end
end

return M
