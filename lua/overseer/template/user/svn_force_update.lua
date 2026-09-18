-- SVN 强制覆盖到远端：svn revert -R + svn update（丢弃版本化文件的本地修改）
-- 作用于当前文件所在目录；完成后自动刷新当前 buffer

return {
  name = 'SVN 强制覆盖',
  desc = 'svn revert -R + update（丢弃本地所有更改）当前文件所在目录',
  builder = function()
    local util = require('utils.overseer_util')
    local cwd = vim.fn.expand('%:p:h')
    if cwd == '' then
      return util.fail_task('SVN 强制覆盖', '没有打开文件，无法定位目录')
    end
    -- 路径统一为正斜杠并转义单引号
    local q = (cwd:gsub('\\', '/')):gsub("'", "''")
    local cmd
    if vim.fn.has('win32') == 1 then
      -- revert 成功才 update；失败则写错误并退出
      cmd = {
        'pwsh',
        '-NoLogo',
        '-NoProfile',
        '-Command',
        table.concat({
          "$ErrorActionPreference = 'Stop'",
          "svn revert -R '" .. q .. "'",
          "if ($LASTEXITCODE -ne 0) { Write-Error 'svn revert 失败，已中止 update'; exit 1 }",
          "svn update '" .. q .. "'",
          'exit $LASTEXITCODE',
        }, '; '),
      }
    else
      cmd = { 'bash', '-lc', "svn revert -R '" .. q .. "' && svn update '" .. q .. "'" }
    end
    return {
      cmd = cmd,
      cwd = cwd,
      name = 'SVN 强制覆盖',
      components = { 'default', 'reload_current_buffer' },
    }
  end,
}
