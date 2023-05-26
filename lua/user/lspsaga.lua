local M = {
  "glepnir/lspsaga.nvim",
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
  }
end

return M
