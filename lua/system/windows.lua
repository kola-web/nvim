vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.opt.shellxquote = ''
-- Get LOCALAPPDATA environment variable
local local_app_data = vim.fn.getenv('LOCALAPPDATA')

if local_app_data and vim.fn.executable('volta') then
  -- Try to find the latest Node.js version installed by Volta
  local volta_node_path = local_app_data .. '\\Volta\\tools\\image\\node'
  local node_versions = vim.fn.glob(volta_node_path .. '\\*', false, true)

  if #node_versions > 0 then
    -- Sort versions to get the latest one
    table.sort(node_versions, function(a, b)
      return a > b
    end)

    local latest_node_version = node_versions[1]
    local node_exe = latest_node_version .. '\\node.exe'
    local node_bin = latest_node_version .. '\\'

    -- Set copilot node command if the executable exists
    if vim.fn.filereadable(node_exe) then
      vim.g.copilot_node_command = node_exe
    end

    -- Add node bin to PATH if the directory exists
    if vim.fn.isdirectory(node_bin) then
      local current_path = vim.fn.getenv('PATH')
      vim.fn.setenv('PATH', node_bin .. ';' .. current_path)
    end
  end
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
