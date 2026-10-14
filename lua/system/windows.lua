-- vim.o.shell 会被第三方插件（如 vim-signify）直接拿来拼接命令字符串执行，
-- 因此必须是「无空格 + 可被 jobstart 直接执行」的路径：
--   Store 版 pwsh 的 WindowsApps 别名不可执行（E475）；完整路径含空格会被拼坏（E903: "C:\Program"）。
-- 故统一用系统自带 PowerShell（真实 exe、无空格、PATH 内）。
-- snacks 终端与 overseer 任务需要 pwsh 7 时，显式用 utils.pwsh 的完整路径数组（不受空格影响）。
vim.opt.shell = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'
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
