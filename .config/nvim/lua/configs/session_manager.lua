local M = {}
function M.config()
  local status, session_manager = pcall(require, "session_manager")
  if not status then
    return
  end

  session_manager.setup(require("core.utils").user_plugin_opts("plugins.session_manager", {
    autoload_mode = "Disabled",
  }))
end

return M
