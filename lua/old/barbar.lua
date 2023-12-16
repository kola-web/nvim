local M = {
  'romgrk/barbar.nvim',
  event = 'BufReadPre',
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
    },
  },
  keys = {
    { '<S-tab>', '<cmd>BufferPrevious<cr>', desc = 'Prev buffer' },
    { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
    { '(', '<cmd>BufferMovePrevious<cr>', desc = 'move prev' },
    { ')', '<cmd>BufferMoveNext<cr>', desc = 'move move' },
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.cmd([[
        let g:lightline={ 'enable': {'statusline': 1, 'tabline': 0} }
    ]])
  end,
  opts = {
    animation = false,
    auto_hide = false,
    tabpages = false,
    insert_at_end = true,
    highlight_visible = false,
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
  },
}
function M.config(_, opts)
  require('barbar').setup(opts)
end

return M
