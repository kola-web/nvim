-- 解析真实 pwsh 可执行路径
-- 背景：Microsoft Store 安装的 pwsh 在 PATH 里只是 App Execution Alias
--       （%LOCALAPPDATA%\Microsoft\WindowsApps\pwsh.exe，reparse point），
--       vim.fn.executable 认为存在，但 vim.jobstart 无法直接执行
--       （E475: 'pwsh' is not executable）。本模块解析 MSI / Store 安装的真实路径，
--       供 vim.o.shell 与 overseer 任务统一使用；路径含空格，调用方应以数组形式传参。

local M = {}

local cached

--- 获取真实可执行的 pwsh 路径（缓存）
--- 优先级：MSI 安装（Program Files）→ Store 安装（Appx InstallLocation）→ 兜底系统 powershell.exe
--- 仅 Windows 有效：macOS/Linux/WSL 返回 nil（调用方应走各自的 Unix/bash 分支）
--- @return string|nil
function M.get()
  if cached then
    return cached
  end
  -- 仅 Windows：Store 别名问题只存在于 Windows
  if vim.fn.has('win32') ~= 1 then
    return nil
  end
  -- 1) MSI 安装
  local msi = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe'
  if vim.fn.filereadable(msi) == 1 then
    cached = msi
    return cached
  end
  -- 2) Microsoft Store 安装：查 Appx InstallLocation（pwsh 升级后版本目录变化也能跟上）
  local ok, out = pcall(vim.fn.system, {
    'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
    '-NoProfile', '-Command',
    '(Get-AppxPackage Microsoft.PowerShell -ErrorAction SilentlyContinue).InstallLocation',
  })
  if ok and type(out) == 'string' then
    local loc = vim.trim(out:gsub('[\r\n]+', ''))
    if loc ~= '' and vim.fn.filereadable(loc .. '\\pwsh.exe') == 1 then
      cached = loc .. '\\pwsh.exe'
      return cached
    end
  end
  -- 3) 兜底：系统自带 Windows PowerShell（真实 exe，可被 jobstart 执行）
  cached = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'
  return cached
end

return M
