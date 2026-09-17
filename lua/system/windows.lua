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
