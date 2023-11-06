local M = {
  'akinsho/bufferline.nvim',
  event = { 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  dependencies = {
    {
      'famiu/bufdelete.nvim',
    },
    {
      'nvim-tree/nvim-web-devicons',
    },
  },
  keys = {
    { '<S-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '(', '<cmd>BufferLineMovePrev<cr>', desc = 'move prev' },
    { ')', '<cmd>BufferLineMoveNext<cr>', desc = 'move move' },
  },
  opts = {
    options = {
      close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
      right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
function M.config(_, opts)
  require('bufferline').setup(opts)
  -- Fix bufferline when restoring a session
  vim.api.nvim_create_autocmd('BufAdd', {
    callback = function()
      vim.schedule(function()
        pcall(nvim_bufferline)
      end)
    end,
  })
end

return M
