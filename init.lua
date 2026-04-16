local has = vim.fn.has
local is_mac = has('macunix')
local is_linux = has('unix')
local is_win = has('win32')
local is_wsl = has('wsl')

if is_mac == 1 then
  require('system.macos')
end
if is_linux == 1 then
  require('system.linux')
end
if is_win == 1 then
  require('system.windows')
end

if is_wsl == 1 then
  require('system.wsl')
end

if vim.g.neovide then
  require('system.neovide')
end

require('options')
require('keymaps')
require('autocommands')

require('user.public')

require('lsp.blink')
require('lsp.conform')
require('lsp.emmet')
require('lsp.lsp')
require('lsp.mason')

require('user.ai')
require('user.autopair')
require('user.bufferline')
require('user.colorizer')
require('user.colorscheme')
require('user.comment')
require('user.debug')
require('user.dropbar')
require('user.files')
require('user.flash')
require('user.grug-far')
require('user.kulala')
require('user.lualine')
require('user.mini')
require('user.neogen')
require('user.overseer')
require('user.persistence')
require('user.preview')
require('user.snacks')
require('user.snippets')
require('user.syntax')
require('user.textcase')
require('user.textobj')
require('user.tmux')
require('user.todo-comments')
require('user.treesitter')
require('user.vcs')
require('user.which-key')

