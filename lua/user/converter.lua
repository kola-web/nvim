local M = {
  'amadeus/vim-convert-color-to',
  event = 'VeryLazy',
}

M.index = 1
M.colorList = { 'hex', 'rgba', 'hsla' }

M.toggleColorFormat = function()
  if M.index > #M.colorList then
    M.index = 1
  end
  vim.cmd.ConvertColorTo(M.colorList[M.index])
  M.index = M.index + 1
end

return M
