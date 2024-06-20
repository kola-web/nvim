local M = {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o', '<cmd>Trouble symbols toggle pinned=true results.win = { relative=win, position=right } focus=true<cr>', desc = 'outline (Trouble)' },
    { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', desc = 'Document Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr> focus=true', desc = 'Workspace Diagnostics (Trouble)' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr> focus=true', desc = 'loclist (Trouble)' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr> focus=true', desc = 'quickfix (Trouble)' },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous Trouble/Quickfix Item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next Trouble/Quickfix Item',
    },
  },
  opts = {},
  config = function(_, opts)
    require('trouble').setup(opts)
    local trouble = require('trouble')
    local symbols = trouble.statusline({
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
    })
    _G.my_symbols = symbols
    -- vim.o.winbar = '%f %{%v:lua.my_symbols.get()%}'
    vim.o.winbar = "%f %{%v:lua.my_symbols.get()%}"
  end,
}

return M
