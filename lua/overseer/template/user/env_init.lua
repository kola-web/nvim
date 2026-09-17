-- 初始化小程序环境配置文件：在项目根创建 .env.development / .env.production
--
-- 预填逻辑（尽量从项目现状推断，减少手填）：
--   APPID        ← project.config.json 顶层 appid
--   URL/UPFILE_URL/IMAGE_URL ← src/app.ts（或 app.js）globalData 里
--                              url/upFileUrl/imageUrl 的当前值（https:// 开头的值）
-- 已存在的文件不会被覆盖；创建完成后提示把 .env.production 改成生产配置。
-- 之后用「环境切换」任务（<leader>xwe）即可切换 dev/pro。

local M = {}

--- 从 start 目录向上查找项目根目录（存在 project.config.json 即视为小程序项目根）
--- @param start string|nil
--- @return string|nil
function M.find_root(start)
  local dir = start or vim.fn.getcwd()
  while dir and dir ~= '' do
    if vim.fn.filereadable(dir .. '/project.config.json') == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      return nil
    end
    dir = parent
  end
  return nil
end

--- 自动检测小程序入口文件（app.ts / app.js）
--- @param root string
--- @return string|nil
function M.find_app_file(root)
  for _, name in ipairs({ 'src/app.ts', 'src/app.js', 'app.ts', 'app.js' }) do
    local f = vim.fs.joinpath(root, name)
    if vim.fn.filereadable(f) == 1 then
      return f
    end
  end
  return nil
end

--- 从入口文件提取 globalData 三值（取第一个 https:// 开头的赋值行）
--- @param app string
--- @return table|nil { url, upFileUrl, imageUrl }
function M.extract_global_data(app)
  local ok, lines = pcall(vim.fn.readfile, app)
  if not ok then
    return nil
  end
  local vals = {}
  for _, line in ipairs(lines) do
    -- Lua pattern 无 | 交替，需逐个键匹配（值须 https:// 开头）
    local k, v = line:match("^%s*(upFileUrl)%s*:%s*'(https://[^']+)'")
    if not k then
      k, v = line:match("^%s*(imageUrl)%s*:%s*'(https://[^']+)'")
    end
    if not k then
      k, v = line:match("^%s*(url)%s*:%s*'(https://[^']+)'")
    end
    if k and v and not vals[k] then
      vals[k] = v
    end
  end
  if vals.url and vals.upFileUrl and vals.imageUrl then
    return vals
  end
  return nil
end

--- 生成 .env 文件内容（行数组，UTF-8 无 BOM 写入）
--- @param appid string
--- @param vals table|nil
--- @param env_name string 'development' | 'production'
--- @return string[]
function M.env_content(appid, vals, env_name)
  return {
    '# 微信小程序环境配置（overseer「环境切换」任务配置源）',
    ('# %s 环境'):format(env_name),
    ('APPID=%s'):format(appid or ''),
    ('URL=%s'):format(vals and vals.url or ''),
    ('UPFILE_URL=%s'):format(vals and vals.upFileUrl or ''),
    ('IMAGE_URL=%s'):format(vals and vals.imageUrl or ''),
  }
end

--- 构造一个快速输出任务（overseer 必须返回可执行 task_defn，不能返回 nil）
--- @param msg string
--- @return table task_defn
function M.quick_task(msg)
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', ("Write-Output '%s'"):format(msg:gsub("'", "''")) }
  else
    cmd = { 'bash', '-lc', ('echo "%s"'):format(msg:gsub('"', '\\"')) }
  end
  return {
    cmd = cmd,
    name = '初始化环境配置',
    components = { 'default' },
  }
end

return {
  name = '初始化环境配置',
  desc = '在项目根创建 .env.development / .env.production（预填 project.config.json appid 与 globalData 当前值）',
  builder = function()
    local util = require('utils.overseer_util')
    local root = M.find_root()
    if not root then
      return util.fail_task('初始化环境配置', '未找到项目根目录（需包含 project.config.json）')
    end
    local app = M.find_app_file(root)
    if not app then
      return util.fail_task('初始化环境配置', '未找到小程序入口文件（src/app.ts、src/app.js、app.ts、app.js）')
    end

    -- 预填值
    local appid = nil
    local config = vim.fs.joinpath(root, 'project.config.json')
    local ok, data = pcall(vim.json.decode, table.concat(vim.fn.readfile(config), '\n'))
    if ok and type(data) == 'table' and data.appid then
      appid = data.appid
    end
    local vals = M.extract_global_data(app)
    if not vals then
      vim.notify('未能从入口文件提取 url/upFileUrl/imageUrl，.env 中相关字段留空，请手动填写', vim.log.levels.WARN)
    end

    local dev_path = vim.fs.joinpath(root, '.env.development')
    local pro_path = vim.fs.joinpath(root, '.env.production')
    local created = {}
    if vim.fn.filereadable(dev_path) ~= 1 then
      vim.fn.writefile(M.env_content(appid, vals, 'development'), dev_path)
      table.insert(created, '.env.development')
    end
    if vim.fn.filereadable(pro_path) ~= 1 then
      vim.fn.writefile(M.env_content(appid, vals, 'production'), pro_path)
      table.insert(created, '.env.production')
    end

    if #created == 0 then
      vim.notify('.env.development / .env.production 均已存在，未改动', vim.log.levels.INFO)
      return M.quick_task('已存在，跳过创建（未改动任何文件）')
    end
    vim.notify(
      ('已创建 %s；请将 .env.production 改为生产环境实际配置'):format(table.concat(created, '、')),
      vim.log.levels.INFO
    )
    return M.quick_task('已创建: ' .. table.concat(created, ', ') .. '（.env.production 需改为生产配置）')
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return M.find_root(cwd) ~= nil
    end,
  },
}
