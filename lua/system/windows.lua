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

vim.g.mini_file_mini_component = function()
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  local templatePath = vim.fn.expand('$HOME/AppData/Local/nvim/template/wxmlComponent')
  local destPath = currentPath .. '/wxmlComponent'

  -- 使用异步 job 避免阻塞
  vim.fn.jobstart({
    'pwsh',
    '-NoLogo',
    '-NoProfile',
    '-Command',
    string.format(
      'Copy-Item -Recurse -Path "%s" -Destination "%s"; Get-ChildItem -Recurse -Path "%s" | ForEach-Object { $_.IsReadOnly = $false }',
      templatePath,
      currentPath,
      destPath
    ),
  }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          MiniFiles.synchronize()
          vim.notify('Component created successfully', vim.log.levels.INFO)
        else
          vim.notify('Failed to create component', vim.log.levels.ERROR)
        end
      end)
    end,
  })
end

vim.g.mini_file_mini_page = function()
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  local templatePath = vim.fn.expand('$HOME/AppData/Local/nvim/template/wxmlPage')
  local destPath = currentPath .. '/wxmlPage'

  -- 使用异步 job 避免阻塞
  vim.fn.jobstart({
    'pwsh',
    '-NoLogo',
    '-NoProfile',
    '-Command',
    string.format(
      'Copy-Item -Recurse -Path "%s" -Destination "%s"; Get-ChildItem -Recurse -Path "%s" | ForEach-Object { $_.IsReadOnly = $false }',
      templatePath,
      currentPath,
      destPath
    ),
  }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          MiniFiles.synchronize()
          vim.notify('Page created successfully', vim.log.levels.INFO)
        else
          vim.notify('Failed to create page', vim.log.levels.ERROR)
        end
      end)
    end,
  })
end
