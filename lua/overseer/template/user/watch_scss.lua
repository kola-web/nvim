-- watch scss 任务：sass --watch 监听当前 buffer 的 .scss 文件，实时编译到同名 .css
-- 触发：<leader>xps（仅 scss buffer 生效）
-- 长任务（不会退出），在 overseer 里可随时停止

local util = require('utils.overseer_util')

return {
  name = 'watch scss',
  desc = 'sass --watch 实时编译当前 scss 文件',
  condition = {
    filetype = { 'scss' },
  },
  builder = function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == '' or not file:match('%.scss$') then
      return util.fail_task('watch scss', '当前 buffer 不是 scss 文件')
    end
    local out = file:gsub('%.scss$', '.css')
    local is_win = vim.fn.has('win32') == 1
    local cmd = is_win
      and vim.list_extend(util.pwsh(), { '-Command', ('sass --watch "%s" "%s"'):format(file, out) })
      or { 'sass', '--watch', file, out }
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
