if not vim.g.vscode then
  require('options')
  require('keymaps')
  require('autocommands')
  require('user.colorscheme')
end
require('Lazy').setup()

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

local ts_utils = require('nvim-treesitter.ts_utils')

local function get_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return nil
  end

  while node do
    local node_type = node:type()

    if node_type == 'element' then
      return 'HTML'
    elseif node_type == 'stylesheet' then
      return 'CSS'
    end

    node = node:parent()
  end

  return ''
end

-- 输出光标所在的部分
vim.keymap.set({ 'i', 'n' }, '<C-i>', function()
  print(get_node_at_cursor())
end, { noremap = true })
