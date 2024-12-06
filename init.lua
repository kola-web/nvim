if not vim.g.vscode then
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

  require('options')
  require('keymaps')
  require('autocommands')
  require('user.colorscheme')
end
require('Lazy').setup()
