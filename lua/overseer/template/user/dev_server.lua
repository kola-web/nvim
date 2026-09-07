-- dev server 任务：在当前项目根目录运行 pnpm dev
-- 项目根 = 从 cwd 向上逐层查找 package.json
-- 输出为终端 buffer（overseer 默认 output.use_terminal = true），vite 彩色/spinner 正常显示
-- 找不到 package.json → vim.notify 提示 + fail_task 立即失败

local util = require('utils.overseer_util')

local M = {}

--- 从 cwd 向上查找包含 package.json 的项目根目录
--- @param cwd string 起始目录
--- @return string|nil root 项目根目录
--- @return string|nil err 未找到的原因
function M.resolve(cwd)
  cwd = cwd or vim.fn.getcwd()
  local dir = vim.fn.fnamemodify(cwd, ':p')
  local seen = {}
  while dir and dir ~= '' and not seen[dir] do
    seen[dir] = true
    local p = vim.fs.joinpath(dir, 'package.json')
    if vim.fn.filereadable(p) == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      break
    end
    dir = parent
  end
  return nil, ('从 %s 向上未找到 package.json'):format(cwd)
end

return {
  name = 'dev server',
  desc = '在当前项目根目录运行 pnpm dev（终端输出）',
  builder = function()
    local root, err = M.resolve()
    if not root then
      vim.notify('[dev server] ' .. err, vim.log.levels.ERROR)
      return util.fail_task('dev server', err)
    end
    -- Windows 上 pnpm 是 .ps1/.cmd，jobstart 无法直接执行，用 pwsh 包装
    local is_win = vim.fn.has('win32') == 1
    local cmd = is_win and { 'pwsh', '-NoLogo', '-NoProfile', '-Command', 'pnpm dev' }
      or { 'pnpm', 'dev' }
    return {
      cmd = cmd,
      cwd = root,
      components = {
        'default',
        { 'on_complete_notify', statuses = { 'FAILURE' } },
      },
    }
  end,
}
