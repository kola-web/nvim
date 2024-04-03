local M = {
  'chrisgrieser/nvim-chainsaw',
  keys = {
    {
      '<C-S-L>',
      function()
        require('chainsaw').variableLog()
      end,
      mode = { 'v' },
      desc = 'Prev buffer',
    },
    {
      '<C-S-L>',
      function()
        local keycodes = vim.api.nvim_replace_termcodes('viw', true, true, true):gsub('\n', '')
        vim.api.nvim_feedkeys(keycodes, 'n', true)
        vim.schedule(function()
          require('chainsaw').variableLog()
        end)
      end,
      mode = { 'n' },
      desc = 'Prev buffer',
      expr = true,
    },
  },
}

return M
