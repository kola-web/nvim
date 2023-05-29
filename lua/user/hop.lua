local M = {
  "phaazon/hop.nvim",
  branch = "v2",
  event = "VeryLazy",
}

M.config = function()
  local status, hop = pcall(require, "hop")
  if not status then
    return
  end

  hop.setup {
    keys = "etovxqpdygfblzhckisuran",
  }
end

return M
