-- Git 强制重置到远端：fetch origin + reset --hard origin/<当前分支>
-- 丢弃本地所有更改（未提交修改 + 本地已提交但不在远端的提交）
-- 用法：无参数，基于当前文件所在 git 仓库执行；完成后自动刷新当前 buffer

local M = {}

--- 从目录向上查找 git 仓库根（存在 .git 即视为根）
--- @param start string
--- @return string|nil
function M.find_git_root(start)
  local dir = start
  while dir and dir ~= '' do
    if vim.fn.isdirectory(dir .. '/.git') == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      return nil
    end
    dir = parent
  end
  return nil
end

return {
  name = 'Git 强制重置',
  desc = 'fetch + reset --hard origin/当前分支（丢弃本地所有更改）',
  builder = function()
    local util = require('utils.overseer_util')
    local filepath = vim.fn.expand('%:p')
    if filepath == '' then
      return util.fail_task('Git 强制重置', '没有打开文件，无法定位 git 仓库')
    end
    local root = M.find_git_root(vim.fn.fnamemodify(filepath, ':h'))
    if not root then
      return util.fail_task('Git 强制重置', '未找到 git 仓库（向上遍历无 .git）')
    end
    local branch = vim.fn.system({ 'git', '-C', root, 'rev-parse', '--abbrev-ref', 'HEAD' }):gsub('%s+$', '')
    if branch == '' or branch == 'HEAD' then
      return util.fail_task('Git 强制重置', '无法确定当前分支（可能处于 detached HEAD），已中止')
    end
    -- 路径统一为正斜杠并转义单引号，避免 shell 引号问题
    local q = (root:gsub('\\', '/')):gsub("'", "''")
    local cmd
    if vim.fn.has('win32') == 1 then
      -- fetch 成功才 reset；失败则写错误并退出
      cmd = {
        'pwsh',
        '-NoLogo',
        '-NoProfile',
        '-Command',
        table.concat({
          "$ErrorActionPreference = 'Stop'",
          "git -C '" .. q .. "' fetch origin",
          "if ($LASTEXITCODE -ne 0) { Write-Error 'git fetch 失败，已中止 reset'; exit 1 }",
          "git -C '" .. q .. "' reset --hard origin/" .. branch,
          'exit $LASTEXITCODE',
        }, '; '),
      }
    else
      cmd = {
        'bash',
        '-lc',
        "git -C '" .. q .. "' fetch origin && git -C '" .. q .. "' reset --hard origin/" .. branch,
      }
    end
    return {
      cmd = cmd,
      cwd = root,
      name = 'Git 强制重置',
      components = { 'default', 'reload_current_buffer' },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return M.find_git_root(cwd) ~= nil
    end,
  },
}
