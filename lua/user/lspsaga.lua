local M = {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
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
    request_timeout = 10000,
  }
end

return M
