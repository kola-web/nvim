local M = {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
}

M.config = function()
  local status_ok, lspsaga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  lspsaga.setup {
    outline = {
      win_position = "left",
    },
    finder = {
      keys = {
        expand_or_jump = "<cr>",
      },
    },
    symbol_in_winbar = {
      enable = true,
    },
    request_timeout = 10000,
  }
end

return M
