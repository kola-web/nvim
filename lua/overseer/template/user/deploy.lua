-- 部署任务：直接执行项目自带的 dist.sh / dist.ps1
-- 查找范围：当前工作目录（cwd）及其上一层目录
-- 系统匹配：Windows 执行 dist.ps1（pwsh），其他平台执行 dist.sh（bash）
-- 找不到脚本 → vim.notify 提示；执行完成 → on_complete_notify 通知
-- 构建/提交/ssh 远程更新的具体逻辑由 dist 脚本自身负责，任务不重复实现（换项目即换脚本）

local M = {}

--- 解析当前环境可执行的 dist 脚本
--- 优先按系统匹配（win32 → dist.ps1，否则 → dist.sh），在 cwd 及其上级目录查找
--- @param cwd string 起始目录
--- @return string|nil script 脚本绝对路径
--- @return string|nil err 未找到/系统不匹配的原因
function M.resolve(cwd)
  cwd = cwd or vim.fn.getcwd()
  local is_win = vim.fn.has('win32') == 1
  local want = is_win and 'dist.ps1' or 'dist.sh'
  local other = is_win and 'dist.sh' or 'dist.ps1'
  local parent = vim.fn.fnamemodify(cwd, ':h')
  local dirs = { cwd, parent }

  -- 1. 按系统找目标脚本
  for _, dir in ipairs(dirs) do
    if dir and dir ~= '' then
      local p = vim.fs.joinpath(dir, want)
      if vim.fn.filereadable(p) == 1 then
        return p
      end
    end
  end

  -- 2. 只有其他平台的脚本 → 提示系统不匹配
  for _, dir in ipairs(dirs) do
    if dir and dir ~= '' then
      local p = vim.fs.joinpath(dir, other)
      if vim.fn.filereadable(p) == 1 then
        return nil, ('当前系统为 %s，未找到 %s，仅找到 %s（%s）'):format(
          is_win and 'Windows' or '非 Windows', want, other, p
        )
      end
    end
  end

  -- 3. 都没有 → 提示查找范围
  return nil, ('未找到 %s / %s（已查找: %s 及其上级 %s）'):format('dist.ps1', 'dist.sh', cwd, parent)
end

return vim.tbl_extend('force', M, {
  name = '打包上线',
  desc = '执行项目 dist 脚本（Windows: dist.ps1 / 其他: dist.sh），自动在 cwd 及上级目录查找',
  builder = function()
    local script, err = M.resolve()
    if not script then
      vim.notify(err, vim.log.levels.ERROR)
      return require('utils.overseer_util').fail_task('打包上线', err)
    end

    local cmd
    if script:match('%.ps1$') then
      cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-File', script }
    else
      cmd = { 'bash', script }
    end

    return {
      cmd = cmd,
      name = '打包上线',
      components = {
        'default',
        { 'on_complete_notify', statuses = { 'SUCCESS', 'FAILURE' } },
      },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return M.resolve(cwd) ~= nil
    end,
  },
})
