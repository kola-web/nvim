local M = {
  'folke/trouble.nvim',
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
  opts = {
    auto_close = true,
    focus = true,
  },
}

return M
