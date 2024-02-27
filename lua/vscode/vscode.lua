if not vim.g.vscode then
  return {}
end

local vscode = require('vscode-neovim')
vim.notify = vscode.notify

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

local enabled = {
  'lazy.nvim',
  'nvim-ts-context-commentstring',
  'mini.comment',
  'vim-repeat',
  'vim-indent-object',
}

local Config = require('lazy.core.config')
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- vimkeymap
keymap('n', 's', "<cmd>lua require('substitute').operator()<cr>", opts)
keymap('n', 'ss', "<cmd>lua require('substitute').line()<cr>", opts)
keymap('n', 'S', "<cmd>lua require('substitute').eol()<cr>", opts)
keymap('x', 's', "<cmd>lua require('substitute').visual()<cr>", opts)
keymap('n', 'sx', "<cmd>lua require('substitute.exchange').operator()<cr>", opts)
keymap('n', 'sxx', "<cmd>lua require('substitute.exchange').line()<cr>", opts)
keymap('x', 'X', "<cmd>lua require('substitute.exchange').visual()<cr>", opts)
keymap('n', 'sxc', "<cmd>lua require('substitute.exchange').cancel()<cr>", opts)

-- Add some vscode specific keymaps
vim.keymap.set('n', '<leader>', function()
  vscode.call('whichkey.show')
end)

-- auto commands
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { highlight = { enable = false } },
  },
}
