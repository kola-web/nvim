local wx = require('utils.wx')
local util = require('utils.overseer_util')

return {
  name = 'wx open',
  desc = '微信开发者工具：在工具中打开项目（自动编译刷新）',
  builder = function()
    if vim.fn.has('win32') ~= 1 then
      return util.fail_task('wx open', '微信开发者工具 CLI 仅支持 Windows（cli.bat）')
    end
    local root = wx.project_root()
    local cli = wx.cli()
    if not root then
      return util.fail_task('wx open', '当前目录不是小程序项目（缺少 project.config.json）')
    end
    if not cli then
      return util.fail_task('wx open', '未找到 cli.bat，请设置环境变量 WX_CLI 指向其路径')
    end

    return {
      cmd = { cli, 'open', '--project', root, '--lang', 'zh' },
      name = 'wx open',
      components = { 'default' },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return vim.fn.filereadable(vim.fs.joinpath(cwd, 'project.config.json')) == 1
    end,
  },
}
