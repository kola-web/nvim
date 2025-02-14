if not vim.g.vscode then
  return {}
end

local vscode = require('vscode')

-- Silent keymap option
local opts = { silent = true, noremap = true }

local enabled = {
  'lazy.nvim',
  'vim-repeat',
  'nvim-treesitter',
  'vim-repeat',
  'nvim-surround',
  'flash.nvim',
  'vim-abolish',
  'mini.operators',
  'mini.ai',
  'nvim-various-textobjs',
  'text-case.nvim',
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

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { highlight = { enable = false } },
  },
}
