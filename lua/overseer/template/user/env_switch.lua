-- 环境切换：切换小程序 .env 配置到 app.ts / project.config.json
-- 触发：<leader>xwe
--
-- 实现已改为纯 Lua（lua/utils/env_switch.lua）：
-- 原来非 Windows 分支走 bash + `sed -i`，macOS 的 BSD sed 要求 -i 后跟备份后缀，
-- 在 mac 上必然失败。纯 Lua 读写不依赖任何 shell，三平台行为一致。

local util = require('utils.overseer_util')
local env_switch = require('utils.env_switch')

--- 任务执行时把已算好的结果回显到 overseer 输出
--- @param lines string[]
--- @return string[]
local function print_cmd(lines)
  local tmp = vim.fn.tempname() .. '.txt'
  vim.fn.writefile(lines, tmp)
  if vim.fn.has('win32') == 1 then
    return vim.list_extend(util.pwsh(), {
      '-Command',
      ("Get-Content -LiteralPath '%s'"):format((tmp:gsub("'", "''"))),
    })
  end
  return { 'cat', tmp }
end

return {
  name = '环境切换',
  desc = '按 .env.development / .env.production 切换 globalData 与 appid',
  builder = function()
    local root = env_switch.find_root()
    if not root then
      return util.fail_task('环境切换', '未找到项目根目录（需包含 project.config.json）')
    end
    local app = env_switch.find_app_file(root)
    if not app then
      return util.fail_task('环境切换', '未找到小程序入口文件（src/app.ts、src/app.js、app.ts、app.js）')
    end

    local current = env_switch.current_env(root, app)
    if not current then
      return util.fail_task('环境切换', '当前 globalData 的 url 与两个 .env 都不匹配，无法判断环境')
    end
    local target = current == 'development' and 'production' or 'development'
    local config = vim.fs.joinpath(root, 'project.config.json')

    local ok, msgs = env_switch.switch(root, app, config, target)
    if not ok then
      return util.fail_task('环境切换', table.concat(msgs, '\n'))
    end

    return {
      cmd = print_cmd(msgs),
      cwd = root,
      name = '环境切换',
      components = {
        'default',
        'env_switch_reload',
      },
      metadata = { files = { app, config } },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return env_switch.find_root(cwd) ~= nil
    end,
  },
}
