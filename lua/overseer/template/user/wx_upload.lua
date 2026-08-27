local wx = require('utils.wx')

return {
  name = 'wx upload',
  desc = '微信开发者工具：上传体验版（需已登录 + 开启服务端口）',
  params = {
    version = { type = 'string', default = '1.0.0', desc = '版本号' },
    desc = { type = 'string', default = 'auto upload', desc = '版本备注（必填）' },
  },
  builder = function(params)
    local root = wx.project_root()
    local cli = wx.cli()
    if not root then
      vim.notify('当前目录不是小程序项目（缺少 project.config.json）', vim.log.levels.ERROR)
      return
    end
    if not cli then
      vim.notify('未找到 cli.bat，请设置环境变量 WX_CLI 指向其路径', vim.log.levels.ERROR)
      return
    end

    return {
      cmd = { cli, 'upload', '--project', root, '--lang', 'zh', '-v', params.version, '-d', params.desc },
      name = 'wx upload',
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
