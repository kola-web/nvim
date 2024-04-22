local M = {
  'folke/trouble.nvim',
  branch = 'dev',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o', '<cmd>Trouble symbols toggle pinned=true results.win = { relative=win, position=right } focus=true<cr>', desc = 'outline (Trouble)' },
    { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', desc = 'Document Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr> focus=true', desc = 'Workspace Diagnostics (Trouble)' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr> focus=true', desc = 'loclist' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr> focus=true', desc = 'quickfix' },
  },
  opts = {},
  config = function(_, opts)
    require('trouble').setup(opts)
    -- local trouble = require('trouble')
    -- local symbols = trouble.statusline({
    --   mode = 'lsp_document_symbols',
    --   groups = {},
    --   title = false,
    --   filter = { range = true },
    --   format = '{kind_icon}{symbol.name:Normal}',
    -- })
    -- _G.my_symbols = symbols
    -- vim.o.winbar = '%{%v:lua.my_symbols.get()%}'
  end,
}

return M
