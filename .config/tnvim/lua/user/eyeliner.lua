local status_ok, eyeliner = pcall(require, "eyeliner")
if not status_ok then return end
eyeliner.setup {
  highlight_on_key = true
}
