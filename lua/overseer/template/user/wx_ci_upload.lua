local wx = require('utils.wx')

-- 把 JS API 脚本写到临时文件（脚本位于 temp，用 NODE_PATH 指向项目 node_modules 以解析 miniprogram-ci）
local function write_script()
  local script = [[
const ci = require('miniprogram-ci');
(async () => {
  const project = new ci.Project({
    appid: process.env.WX_APPID,
    type: 'miniProgram',
    projectPath: process.env.WX_PROJECT,
    privateKeyPath: process.env.WX_KEY,
    ignores: ['node_modules/**/*'],
  });
  try {
    await ci.upload({
      project,
      version: process.env.WX_VERSION,
      desc: process.env.WX_DESC,
      robot: Number(process.env.WX_ROBOT || 1),
      setting: { es6: true, minify: true },
    });
    console.log('UPLOAD_OK');
    process.exit(0);
  } catch (e) {
    console.error('UPLOAD_FAIL:', (e && e.message) || e);
    process.exit(1);
  }
})();
]]
  local f = vim.fn.tempname() .. '.js'
  vim.fn.writefile(vim.split(script, '\n', { plain = true }), f)
  return f
end

return {
  name = 'wx ci upload',
  desc = 'miniprogram-ci 上传体验版（无需开发者工具，需代码上传密钥 + IP 白名单；npm i -g miniprogram-ci）',
  params = {
    version = { type = 'string', default = '1.0.0', desc = '版本号' },
    desc = { type = 'string', default = 'auto upload', desc = '版本备注' },
    robot = { type = 'integer', default = 1, desc = '机器人编号 1-30' },
  },
  builder = function(params)
    local root = wx.project_root()
    local appid = wx.appid(root)
    local key = wx.ci_key(root)
    if not root or not appid then
      vim.notify('当前目录不是小程序项目（缺少 project.config.json / appid）', vim.log.levels.ERROR)
      return
    end
    if not key then
      vim.notify('未找到代码上传密钥，请放到项目根目录 private.<appid>.key 或设置 WX_CI_KEY', vim.log.levels.ERROR)
      return
    end
    if vim.fn.executable('node') ~= 1 then
      vim.notify('未找到 node', vim.log.levels.ERROR)
      return
    end

    local script = write_script()
    return {
      cmd = { 'node', script },
      env = {
        WX_APPID = appid,
        WX_PROJECT = root,
        WX_KEY = key,
        WX_VERSION = params.version,
        WX_DESC = params.desc,
        WX_ROBOT = tostring(params.robot),
        NODE_PATH = root .. '/node_modules',
      },
      name = 'wx ci upload',
      components = { 'default' },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      local cfg = vim.fs.joinpath(cwd, 'project.config.json')
      if vim.fn.filereadable(cfg) ~= 1 then
        return false
      end
      return wx.ci_key(vim.fs.dirname(cfg)) ~= nil and vim.fn.executable('node') == 1
    end,
  },
}
