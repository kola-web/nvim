local M = {
  'akinsho/bufferline.nvim',
  event = { 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  dependencies = {
    {
      'famiu/bufdelete.nvim',
    },
  },
}
function M.config()
  require('bufferline').setup({
    options = {
      close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
      right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
      separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  })
end

return M
