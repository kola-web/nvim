--- 微信小程序开发工具集成：路径 / 项目识别 / cli 定位等公共逻辑
local M = {}

-- 从当前目录向上查找包含 project.config.json 的项目根目录
function M.project_root()
  local found = vim.fs.find('project.config.json', { upward = true, type = 'file' })
  if #found > 0 then
    return vim.fs.dirname(found[1])
  end
  return nil
end

function M.is_miniprogram()
  return M.project_root() ~= nil
end

-- 读取 project.config.json 里的 appid
function M.appid(root)
  root = root or M.project_root()
  if not root then
    return nil
  end
  local f = root .. '/project.config.json'
  local ok, data = pcall(vim.json.decode, table.concat(vim.fn.readfile(f), '\n'))
  if ok and data and data.appid then
    return data.appid
  end
  return nil
end

-- 定位微信开发者工具 cli.bat；可用环境变量 WX_CLI 覆盖
function M.cli()
  local env = vim.fn.getenv('WX_CLI')
  if env and env ~= '' and vim.fn.filereadable(env) == 1 then
    return env
  end
  local candidates = {
    'C:/Program Files (x86)/Tencent/微信web开发者工具/cli.bat',
    'C:/Program Files/Tencent/微信web开发者工具/cli.bat',
    'C:/Program Files (x86)/Tencent/微信开发者工具/cli.bat',
    'C:/Program Files/Tencent/微信开发者工具/cli.bat',
    vim.fn.expand('~/AppData/Local/微信开发者工具/cli.bat'),
  }
  for _, p in ipairs(candidates) do
    if vim.fn.filereadable(p) == 1 then
      return p
    end
  end
  return nil
end

-- 预览二维码图片的临时路径
function M.qr_path()
  return vim.fn.tempname() .. '.png'
end

-- miniprogram-ci 代码上传密钥路径：优先 WX_CI_KEY，其次项目根下 private.<appid>.key
function M.ci_key(root)
  root = root or M.project_root()
  local env = vim.fn.getenv('WX_CI_KEY')
  if env and env ~= '' then
    return env
  end
  if root then
    local appid = M.appid(root)
    if appid then
      local p = root .. '/private.' .. appid .. '.key'
      if vim.fn.filereadable(p) == 1 then
        return p
      end
    end
  end
  return nil
end

return M
