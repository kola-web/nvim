local M = {
  'simrat39/symbols-outline.nvim',
  event = 'VeryLazy',
  config = function()
    require('symbols-outline').setup()
  end,
}

return M
