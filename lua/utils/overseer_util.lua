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
    -- bash 双引号内需要转义 \ " ` $，否则路径/信息里的特殊字符会被 shell 展开
    local esc = msg
      :gsub('\\', '\\\\')
      :gsub('"', '\\"')
      :gsub('`', '\\`')
      :gsub('%$', '\\$')
    cmd = { '/bin/bash', '-lc', ('echo "%s" >&2; exit 1'):format(esc) }
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

-- ==== 项目 dist 脚本解析（「提交图片」/「打包上线」共用）====
-- 原来两个模板各自实现一遍、且只看 cwd（+上一层），mac 上极易扑空。
-- 统一规则：buffer 所在目录 → cwd，各自向上逐级查找，命中即返回。

--- 向上查找的最大层级，避免从很深的路径一路爬到 / 去找脚本
M.MAX_UP = 6

--- 平台对应的脚本名
--- @return string want 本系统要执行的脚本名
--- @return string other 另一个平台的脚本名
function M.dist_names()
  local is_win = vim.fn.has('win32') == 1
  return is_win and 'dist.ps1' or 'dist.sh', is_win and 'dist.sh' or 'dist.ps1'
end

--- 目录绝对化并去掉末尾斜杠（:p 处理目录会带 /，joinpath 后会出现双斜杠）
--- @param dir string
--- @return string
function M.normalize_dir(dir)
  local abs = vim.fn.fnamemodify(dir, ':p')
  if #abs > 1 then
    abs = abs:gsub('/+$', '')
  end
  return abs
end

--- 从 start 向上逐级查找文件名（含 start 自身），到 home / home 上一级 / 根目录即停
--- @param start string 起始目录
--- @param name string 目标文件名
--- @return string|nil 命中文件的绝对路径
function M.find_up(start, name)
  if not start or start == '' then
    return nil
  end
  local home = M.normalize_dir(vim.fn.expand('~'))
  local cur = M.normalize_dir(start)
  for _ = 1, M.MAX_UP do
    local p = vim.fs.joinpath(cur, name)
    if vim.fn.filereadable(p) == 1 then
      return p
    end
    if cur == home or cur == vim.fs.dirname(home) or cur == '/' then
      return nil
    end
    local parent = vim.fs.dirname(cur)
    if not parent or parent == cur then
      return nil
    end
    cur = parent
  end
  return nil
end

--- 候选起点：当前 buffer 所在目录优先，其次 cwd
--- @return string[]
function M.search_roots()
  local roots = {}
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.bo.buftype == '' and bufname ~= '' then
    table.insert(roots, vim.fn.fnamemodify(bufname, ':p:h'))
  end
  table.insert(roots, vim.fn.getcwd())
  return roots
end

--- 解析本系统可执行的 dist 脚本
--- @return string|nil script 脚本绝对路径
--- @return string|nil err 未找到 / 系统不匹配的原因
function M.resolve_dist()
  local want, other = M.dist_names()
  local roots = M.search_roots()

  -- 1. 按系统找目标脚本（每个起点各自向上查找）
  for _, root in ipairs(roots) do
    local p = M.find_up(root, want)
    if p then
      return p
    end
  end

  -- 2. 只找到另一平台的脚本 → 说明系统不匹配
  for _, root in ipairs(roots) do
    local p = M.find_up(root, other)
    if p then
      return nil,
        ('当前系统为 %s，需要 %s，但只找到 %s（%s）'):format(vim.fn.has('win32') == 1 and 'Windows' or '非 Windows', want, other, p)
    end
  end

  -- 3. 都没有 → 列出查找起点，方便区分「脚本放错目录」还是「cwd 不对」
  return nil,
    ('未找到 %s（Windows 用 dist.ps1，其他系统用 dist.sh）。已从以下目录各向上查找 %d 层: %s'):format(
      want,
      M.MAX_UP,
      table.concat(roots, ' , ')
    )
end

--- 构造「执行项目 dist 脚本」的任务定义；找不到脚本时返回 FAILURE 任务（builder 不能返回 nil）
--- @param name string 任务名
--- @return table task_defn
function M.dist_task(name)
  local script, err = M.resolve_dist()
  if not script then
    vim.notify(err, vim.log.levels.ERROR)
    return M.fail_task(name, err)
  end

  local cmd
  if script:match('%.ps1$') then
    cmd = vim.list_extend(M.pwsh(), { '-File', script })
  else
    -- 绝对路径 /bin/bash：不依赖 PATH 里有没有 bash（GUI 启动的 nvim PATH 很窄）
    cmd = { '/bin/bash', script }
  end

  return {
    cmd = cmd,
    -- 任务 cwd 跟随脚本所在目录：脚本内 cd ./web_src 这类相对路径才会按项目根解析
    cwd = vim.fn.fnamemodify(script, ':h'),
    name = name,
    components = {
      'default',
      { 'on_complete_notify', statuses = { 'SUCCESS', 'FAILURE' } },
    },
  }
end

return M
