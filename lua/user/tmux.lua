local M = {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
}

function M.config()
  local status_ok, tmux = pcall(require, "tmux")
  if not status_ok then
    return
  end

  tmux.setup {
    copy_sync = {
      enable = false,
    },
    navigation = {
      enable_default_keybindings = true,
    },
    resize = {
      enable_default_keybindings = false,
    },
  }
end

return M
