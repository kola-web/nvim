local wx = require('utils.wx')
local util = require('utils.overseer_util')

return {
  name = 'wx preview',
  desc = '微信开发者工具：生成预览二维码图片并自动打开（需已登录 + 开启服务端口）',
  builder = function()
    local root = wx.project_root()
    local cli = wx.cli()
    if not root then
      return util.fail_task('wx preview', '当前目录不是小程序项目（缺少 project.config.json）')
    end
    if not cli then
      return util.fail_task('wx preview', '未找到微信开发者工具 CLI，请设置环境变量 WX_CLI 指向 cli.bat / Contents/MacOS/cli')
    end

    local qr = wx.qr_path()
    local cmd
    if wx.is_win() then
      -- Windows：pwsh 执行，成功后用系统默认看图软件打开
      local sh = string.format(
        '& "%s" preview --project "%s" --lang zh --qr-format image --qr-output "%s"; if ($LASTEXITCODE -eq 0) { Start-Process "%s" }',
        cli,
        root,
        qr,
        qr
      )
      cmd = vim.list_extend(util.pwsh(), { '-Command', sh })
    else
      -- macOS / Linux：直接跑 cli，成功后用 open / xdg-open 打开二维码
      local opener = vim.fn.has('mac') == 1 and 'open' or 'xdg-open'
      local sh = table.concat({
        wx.shq(cli) .. ' preview --project ' .. wx.shq(root)
          .. ' --lang zh --qr-format image --qr-output ' .. wx.shq(qr),
        '&& ' .. opener .. ' ' .. wx.shq(qr),
      }, ' ')
      cmd = { 'bash', '-lc', sh }
    end

    return {
      cmd = cmd,
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
