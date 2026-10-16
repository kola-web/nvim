-- compile scss 任务：用 sass 编译当前 buffer 的 .scss 文件到同名 .css
-- 触发：<leader>xS（仅 scss buffer 生效）
-- 输出：overseer buffer；失败弹 snacks 通知

local util = require('utils.overseer_util')

return {
  name = 'compile scss',
  desc = '用 sass 编译当前 buffer 的 scss 文件',
  condition = {
    filetype = { 'scss' },
  },
  builder = function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == '' or not file:match('%.scss$') then
      return util.fail_task('compile scss', '当前 buffer 不是 scss 文件')
    end
    local out = file:gsub('%.scss$', '.css')
    local is_win = vim.fn.has('win32') == 1
    local cmd = is_win
      and vim.list_extend(util.pwsh(), { '-Command', ('sass --no-source-map "%s" "%s"'):format(file, out) })
      or { 'sass', '--no-source-map', file, out }
    return {
      cmd = cmd,
      cwd = vim.fs.dirname(file),
      components = {
        'default',
        { 'on_complete_notify', statuses = { 'FAILURE' } },
      },
    }
  end,
}
