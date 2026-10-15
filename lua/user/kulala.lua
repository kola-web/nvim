vim.pack.add({
  'https://github.com/mistweaverco/kulala.nvim',
})

local loaded = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  callback = function()
    if loaded then
      loaded = true
      return
    end
    local kulala = require('kulala')
    kulala.setup({
      global_keymaps = false,
      global_keymaps_prefix = '<leader>k',
      kulala_keymaps_prefix = '',
    })
  end,
  desc = 'load kulala for http files',
})
