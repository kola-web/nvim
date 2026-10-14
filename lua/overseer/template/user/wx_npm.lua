local wx = require('utils.wx')

return {
  name = 'wx build-npm',
  desc = '微信开发者工具：触发 npm 构建（需开启服务端口）',
  builder = function()
    -- 微信开发者工具 CLI 是 Windows 限定（cli.bat），macOS/Linux/WSL 直接失败提示
    if vim.fn.has('win32') ~= 1 then
      return require('utils.overseer_util').fail_task('wx build-npm', '微信开发者工具 CLI 仅支持 Windows（cli.bat）')
    end
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
      cmd = { cli, 'build-npm', '--project', root, '--lang', 'zh' },
      name = 'wx build-npm',
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
