local M = {}

function M.config()
  local status, session_manager = pcall(require, "session_manager")
  if status then
    session_manager.setup(doomnvim.user_plugin_opts("plugins.session_manager", {
      autoload_mode = "Disabled",
    }))
  end
end

return M
