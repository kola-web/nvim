local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
}

M.opts = {
  char = '│',
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = true,
  buftype_exclude = { 'terminal', 'nofile' },
  filetype_exclude = {
    'help',
    'alpha',
    'dashboard',
    'neo-tree',
    'Trouble',
    'lazy',
    'mason',
    'notify',
    'toggleterm',
    'lazyterm',
  },
}
-- create 1-100 arr

return M
