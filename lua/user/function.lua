local M = {}

M.compare_to_clipboard = function()
  local ftype = vim.api.nvim_eval '&filetype'
  vim.cmd 'vsplit'
  vim.cmd 'enew'
  vim.cmd 'normal! P'
  vim.cmd 'setlocal buftype=nowrite'
  vim.cmd('set filetype=' .. ftype)
  vim.cmd 'diffthis'
  vim.cmd [[execute "normal! \<C-w>h"]]
  vim.cmd 'diffthis'
end

return M
