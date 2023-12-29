-- vim.keymap.set('n', '<leader>', [[<cmd>call VSCodeNotify('whichkey.show')<cr>]])
if not vim.g.vscode then
  return {}
end

local enabled = {
  'lazy.nvim',
  'flit.nvim',
  'mini.comment',
  'nvim-ts-context-commentstring',
  'vim-repeat',
  'vim-abolish',
  'substitute.nvim',
}

local Config = require('lazy.core.config')
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

-- substitute
keymap('n', 's', "<cmd>lua require('substitute').operator()<cr>", opts)
keymap('n', 'ss', "<cmd>lua require('substitute').line()<cr>", opts)
keymap('n', 'S', "<cmd>lua require('substitute').eol()<cr>", opts)
keymap('x', 's', "<cmd>lua require('substitute').visual()<cr>", opts)
vim.keymap.set('n', 'sx', "<cmd>lua require('substitute.exchange').operator()<cr>", opts)
vim.keymap.set('n', 'sxx', "<cmd>lua require('substitute.exchange').line()<cr>", opts)
vim.keymap.set('x', 'X', "<cmd>lua require('substitute.exchange').visual()<cr>", opts)
vim.keymap.set('n', 'sxc', "<cmd>lua require('substitute.exchange').cancel()<cr>", opts)

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return {
}
