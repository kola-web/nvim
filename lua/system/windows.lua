vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.opt.shellxquote = ''
vim.g.copilot_node_command = 'C:\\Users\\kola\\AppData\\Local\\Volta\\tools\\image\\node\\22.18.0\\node.exe'

if vim.fn.executable('volta') then
  local current_path = vim.fn.getenv('PATH')
  local node_bin = vim.fn.expand(vim.fn.getenv('LOCALAPPDATA') .. '/Volta/tools/image/node/22.18.0/')
  vim.fn.setenv('PATH', node_bin .. ';' .. current_path)
end

vim.g.mini_component = function(state)
  local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
  local node = state.tree:get_node()
  local currentPath = node.type == 'file' and node._parent_id or node.id
  vim.fn.system({
    'pwsh',
    '-Command',
    'Copy-Item -Recurse -Path "$HOME\\AppData\\Local\\nvim\\template\\wxmlComponent" -Destination "'
      .. currentPath
      .. '"; '
      .. 'Get-ChildItem -Recurse -Path "'
      .. currentPath
      .. '\\wxmlComponent" | ForEach-Object { $_.IsReadOnly = $false }',
  })
  fs_actions.rename_node(currentPath .. '/wxmlComponent', function(_, path)
    vim.cmd('edit ' .. path .. '/index.wxml')
  end)
end

vim.g.mini_page = function(state)
  local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
  local node = state.tree:get_node()
  local currentPath = node.type == 'file' and node._parent_id or node.id
  vim.fn.system({
    'pwsh',
    '-Command',
    'Copy-Item -Recurse -Path "$HOME\\AppData\\Local\\nvim\\template\\wxmlPage" -Destination "'
      .. currentPath
      .. '"; '
      .. 'Get-ChildItem -Recurse -Path "'
      .. currentPath
      .. '\\wxmlPage" | ForEach-Object { $_.IsReadOnly = $false }',
  })
  fs_actions.rename_node(currentPath .. '/wxmlPage', function(_, path)
    vim.cmd('edit ' .. path .. '/index.wxml')
  end)
end

local function escape_pattern(text)
  return text:gsub('([%.%+%-%*%?%[%]%^%$%(%)%%])', '%%%1')
end

vim.g.mini_file_mini_component = function()
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'pwsh',
    '-Command',
    'Copy-Item -Recurse -Path "$HOME\\AppData\\Local\\nvim\\template\\wxmlComponent" -Destination "'
      .. currentPath
      .. '"; '
      .. 'Get-ChildItem -Recurse -Path "'
      .. currentPath
      .. '\\wxmlComponent" | ForEach-Object { $_.IsReadOnly = $false }',
  })
  MiniFiles.synchronize()
end

vim.g.mini_file_mini_page = function()
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'pwsh',
    '-Command',
    'Copy-Item -Recurse -Path "$HOME\\AppData\\Local\\nvim\\template\\wxmlPage" -Destination "'
      .. currentPath
      .. '"; '
      .. 'Get-ChildItem -Recurse -Path "'
      .. currentPath
      .. '\\wxmlPage" | ForEach-Object { $_.IsReadOnly = $false }',
  })
  MiniFiles.synchronize()
end
