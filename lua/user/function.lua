local M = {}

M.compare_to_clipboard = function()
  local ftype = vim.api.nvim_eval "&filetype"
  vim.cmd "vsplit"
  vim.cmd "enew"
  vim.cmd "normal! P"
  vim.cmd "setlocal buftype=nowrite"
  vim.cmd("set filetype=" .. ftype)
  vim.cmd "diffthis"
  vim.cmd [[execute "normal! \<C-w>h"]]
  vim.cmd "diffthis"
end

M.is_vue = function()
  local util = require "lspconfig.util"
  local vue_path = util.path.join(project_root, "node_modules", "vue")
  local is_vue = vim.fn.isdirectory(vue_path) == 1
  return is_vue
end

return M
