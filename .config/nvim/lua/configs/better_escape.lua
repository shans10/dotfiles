local M = {}

function M.config()
  local present, better_escape = pcall(require, "better_escape")
  if present then
    better_escape.setup(doomnvim.user_plugin_opts "plugins.better_escape")
  end
end

return M
