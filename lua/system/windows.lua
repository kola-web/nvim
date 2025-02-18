vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.opt.shellxquote = ''

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
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.fs_type == 'directory' and file.path or string.gsub(file.path, '/' .. escape_pattern(file.name), '', 1)
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
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.fs_type == 'directory' and file.path or string.gsub(file.path, '/' .. escape_pattern(file.name), '', 1)
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
