-- overseer 任务公共工具
-- 背景: overseer 的 build_task_args 对 builder() 返回值不做 nil 检查（template.lua:271）
--       run_task 快捷方式下 builder 返回 nil 会直接 E5108 崩溃。
--       因此 builder 永远不能返回 nil：找不到目标时应返回"立即失败"的任务。

local M = {}

--- pwsh 命令前缀：{ 真实pwsh路径, -NoLogo, -NoProfile }，后续追加 -Command / -File 参数
--- 仅 Windows 可用：Windows 上 pwsh 若为 Microsoft Store 别名，jobstart 无法直接执行（E475），必须用真实路径
--- macOS/Linux/WSL 请走各自的 bash 分支（调用方均以 vim.fn.has('win32') 保护）
function M.pwsh()
  assert(vim.fn.has('win32') == 1, 'utils.overseer_util.pwsh 仅支持 Windows')
  return { require('utils.pwsh').get(), '-NoLogo', '-NoProfile' }
end

--- 构造一个立即失败的任务（输出错误信息 → 退出码 1 → 弹 FAILURE 通知）
--- @param name string 任务名
--- @param msg string 错误信息
--- @return table task_defn
function M.fail_task(name, msg)
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = vim.list_extend(M.pwsh(), { '-Command', ("Write-Error '%s'; exit 1"):format(msg:gsub("'", "''")) })
  else
    cmd = { 'bash', '-lc', ('echo "%s" >&2; exit 1'):format(msg:gsub('"', '\\"')) }
  end
  return {
    cmd = cmd,
    name = name,
    components = {
      'default',
      { 'on_complete_notify', statuses = { 'FAILURE' } },
    },
  }
end

return M
