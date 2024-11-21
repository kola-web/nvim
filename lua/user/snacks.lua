local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = function()
    ---@type snacks.Config
    return {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
    }
  end,
}

return M
