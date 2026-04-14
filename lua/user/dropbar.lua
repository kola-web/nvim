local dropbar_ok, dropbar = pcall(require, 'dropbar')
if dropbar_ok then
  dropbar.setup({
    icons = {
      kinds = {
        symbols = require('mini.icons'),
      },
    },
  })
end

vim.keymap.set('n', '<leader>;', function()
  if dropbar_ok then
    local dropbar_api = require('dropbar.api')
    dropbar_api.pick()
  end
end, { desc = 'Pick symbols in winbar' })
