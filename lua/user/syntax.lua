vim.pack.add({
  'https://github.com/fladson/vim-kitty',
  'https://github.com/fei6409/log-highlight.nvim',
})

local log_highlight = require('log-highlight')
log_highlight.setup({})
