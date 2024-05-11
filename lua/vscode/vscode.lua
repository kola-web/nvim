if not vim.g.vscode then
  return {}
end

local vscode = require('vscode-neovim')

-- Silent keymap option
local opts = { silent = true, noremap = true }

local enabled = {
  'lazy.nvim',
  'vim-repeat',
  'mini.indentscope',
  'vim-textobj-user',
  'vim-indent-object',
  'vim-textobj-entire',
  'vim-textobj-xmlattr',
  'vim-textobj-line',
  'targets.vim',
  'nvim-treesitter',
  'vim-abolish',
  'vim-repeat',
  'nvim-surround',
  'substitute.nvim'
}

local Config = require('lazy.core.config')
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

----------------------
-- auto commands
----------------------
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

return {}
