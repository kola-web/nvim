local wx = require('utils.wx')

return {
  name = 'wx preview',
  desc = '微信开发者工具：生成预览二维码图片并自动打开（需已登录 + 开启服务端口）',
  builder = function()
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

    local qr = wx.qr_path()
    -- 用 pwsh 执行：生成图片二维码，成功后用系统默认看图软件打开
    local sh = string.format(
      '& "%s" preview --project "%s" --lang zh --qr-format image --qr-output "%s"; if ($LASTEXITCODE -eq 0) { Start-Process "%s" }',
      cli,
      root,
      qr,
      qr
    )

    return {
      cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', sh },
      name = 'wx preview',
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
