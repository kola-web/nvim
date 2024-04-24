if not vim.g.vscode then
  return {}
end

local vscode = require('vscode-neovim')
vim.notify = vscode.notify

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt

opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.whichwrap:append('<,>,[,],h,l') -- 允许在到达行首/行尾时使用的键


return {}
