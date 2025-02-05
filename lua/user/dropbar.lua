local M = {
  'Bekaboo/dropbar.nvim',
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })

    vim.ui.select = require('dropbar.utils.menu').select
  end,
}

return M
