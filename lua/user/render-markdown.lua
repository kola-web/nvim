vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

require('render-markdown').setup({
  file_types = { 'markdown', 'codecompanion' },
}) -- only mandatory if you want to set custom options
