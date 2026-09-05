-- 切换微信小程序环境（dev ↔ pro）
-- dev:  https://m.igg4.hbraas.com / appid wxc3cdb3c4d4f62cea
-- pro:  https://m.igg4.hbsaas.com / appid wx346254575bd711a7
-- 切换范围:
--   src/app.ts           → url / upFileUrl / imageUrl 三行注释切换
--   project.config.json  → "appid" 字段替换
-- 用法: 无参数，运行一次即切到另一个环境（自动检测当前激活环境）
-- 完成后自动刷新已打开的 app.ts / project.config.json buffer

local M = {}

--- 从 start 目录向上查找项目根目录
--- 判定：project.config.json + src/app.ts（微信小程序项目特征）
--- @param start string|nil
--- @return string|nil
function M.find_root(start)
  local dir = start or vim.fn.getcwd()
  while dir and dir ~= '' do
    if vim.fn.filereadable(dir .. '/project.config.json') == 1 and vim.fn.filereadable(dir .. '/src/app.ts') == 1 then
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

-- PowerShell 切换脚本（写入临时文件执行，避免引号转义问题）
local PW = [==[
$ErrorActionPreference = 'Stop'
$file = '__APP_FILE__'
$config = '__CONFIG_FILE__'

$content = [IO.File]::ReadAllText($file)

# 检测当前激活环境（-cmatch 区分大小写，避免误匹配 upFileUrl）
if ($content -cmatch "(?m)^\s*url:\s*'https://m\.igg4\.hbsaas\.com") {
  $cur = 'pro'
} elseif ($content -cmatch "(?m)^\s*url:\s*'https://m\.igg4\.hbraas\.com") {
  $cur = 'dev'
} else {
  Write-Output '[FAIL] 无法识别当前环境（未找到 hbraas/hbsaas 激活行）'
  exit 1
}

$to = 'dev'
if ($cur -eq 'dev') { $to = 'pro' }
Write-Output "当前环境: $cur"
Write-Output "切换到: $to"

# 目标激活域名的三行去注释，另一个域名的三行加注释
$active = 'https://m.igg4.hbraas.com'
$inactive = 'https://m.igg4.hbsaas.com'
if ($to -eq 'pro') {
  $active = 'https://m.igg4.hbsaas.com'
  $inactive = 'https://m.igg4.hbraas.com'
}

$activeEsc = [regex]::Escape($active)
$inactiveEsc = [regex]::Escape($inactive)

# 激活 $active：去掉行首注释（保留缩进）
$content = $content -creplace ("(?m)^(\s*)//\s*((?:url|upFileUrl|imageUrl):\s*'" + $activeEsc + "[^']*',)"), '$1$2'
# 注释 $inactive：加上行首注释
$content = $content -creplace ("(?m)^(\s*)((?:url|upFileUrl|imageUrl):\s*'" + $inactiveEsc + "[^']*',)"), '$1// $2'

# UTF-8 无 BOM 写回 app.ts
[IO.File]::WriteAllText($file, $content, [Text.UTF8Encoding]::new($false))

# 校验 app.ts
$check = [IO.File]::ReadAllText($file)
if ($check -cmatch ("(?m)^\s*url:\s*'" + $activeEsc)) {
  Write-Output "app.ts 切换完成: $active 已激活"
} else {
  Write-Output '[FAIL] app.ts 切换后校验未通过'
  exit 1
}

# --- 切换 project.config.json appid ---
$devAppid = 'wxc3cdb3c4d4f62cea'
$proAppid = 'wx346254575bd711a7'
$targetAppid = $devAppid
if ($to -eq 'pro') { $targetAppid = $proAppid }

$cfg = [IO.File]::ReadAllText($config)
# 只匹配顶层的 appid（2 空格缩进）；condition 等嵌套字段下的 appid 不切换
if ($cfg -notmatch '(?m)^  "appid"\s*:\s*"wx[^"]*"') {
  Write-Output '[FAIL] project.config.json 未找到顶层 appid 字段'
  exit 1
}
$cfg = $cfg -creplace '(?m)^  ("appid"\s*:\s*")wx[^"]*(")', ('  $1' + $targetAppid + '$2')
[IO.File]::WriteAllText($config, $cfg, [Text.UTF8Encoding]::new($false))

# 校验 project.config.json（顶层 appid 已更新）
$cfgCheck = [IO.File]::ReadAllText($config)
if ($cfgCheck -cmatch ('(?m)^  "appid"\s*:\s*"' + $targetAppid + '"')) {
  Write-Output "project.config.json appid 已更新: $targetAppid"
} else {
  Write-Output '[FAIL] project.config.json appid 校验未通过'
  exit 1
}

Write-Output '全部完成 (UTF-8 无 BOM)'
]==]

-- bash 切换脚本（Linux/macOS）
local SH = [==[
#!/usr/bin/env bash
set -e
FILE="__APP_FILE__"
CONFIG="__CONFIG_FILE__"

if grep -q "url: 'https://m.igg4.hbsaas.com" "$FILE"; then
  cur=pro
elif grep -q "url: 'https://m.igg4.hbraas.com" "$FILE"; then
  cur=dev
else
  echo "[FAIL] 无法识别当前环境"; exit 1
fi

to=dev
[ "$cur" = dev ] && to=pro
echo "当前环境: $cur"
echo "切换到: $to"

if [ "$to" = pro ]; then
  sed -i -E "s|^([[:space:]]*)//[[:space:]]*((url|upFileUrl|imageUrl): '[^']*hbraas\.com[^']*',)|\1\2|" "$FILE"
  sed -i -E "s|^([[:space:]]*)((url|upFileUrl|imageUrl): '[^']*hbsaas\.com[^']*',)|\1// \2|" "$FILE"
else
  sed -i -E "s|^([[:space:]]*)//[[:space:]]*((url|upFileUrl|imageUrl): '[^']*hbsaas\.com[^']*',)|\1\2|" "$FILE"
  sed -i -E "s|^([[:space:]]*)((url|upFileUrl|imageUrl): '[^']*hbraas\.com[^']*',)|\1// \2|" "$FILE"
fi

# 切换 project.config.json 顶层 appid（condition 等嵌套字段下的 appid 不切换）
DEV_APPID="wxc3cdb3c4d4f62cea"
PRO_APPID="wx346254575bd711a7"
if [ "$to" = pro ]; then TARGET_APPID="$PRO_APPID"; else TARGET_APPID="$DEV_APPID"; fi
grep -q '^  "appid"[[:space:]]*:[[:space:]]*"wx' "$CONFIG" || { echo "[FAIL] project.config.json 未找到顶层 appid"; exit 1; }
sed -i -E "s|^  (\"appid\"[[:space:]]*:[[:space:]]*\")wx[^\"]*(\")|  \1$TARGET_APPID\2|" "$CONFIG"

echo "切换完成: app.ts 环境=$to, appid=$TARGET_APPID"
]==]

return {
  name = '环境切换',
  desc = '切换 app.ts 环境与 project.config.json appid：dev(hbraas) ↔ pro(hbsaas)',
  builder = function()
    local root = M.find_root()
    if not root then
      local msg = '未找到项目根目录（需包含 project.config.json 与 src/app.ts）'
      vim.notify(msg, vim.log.levels.ERROR)
      return require('utils.overseer_util').fail_task('环境切换', msg)
    end
    local app = vim.fs.joinpath(root, 'src/app.ts')
    local config = vim.fs.joinpath(root, 'project.config.json')
    -- 临时脚本放在系统 TEMP（tempname 的文件会在 nvim 退出时被删，任务可能还没跑完）
    local tmp_dir = (vim.fn.has('win32') == 1 and (os.getenv('TEMP') or 'C:/Windows/Temp') or '/tmp')
    local tmp = tmp_dir .. '/env_switch_' .. vim.fn.getpid() .. (vim.fn.has('win32') == 1 and '.ps1' or '.sh')
    local script, cmd
    if vim.fn.has('win32') == 1 then
      script = (PW:gsub('__APP_FILE__', (app:gsub('%%', '%%%%')))):gsub('__CONFIG_FILE__', (config:gsub('%%', '%%%%')))
      cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-File', tmp }
    else
      script = (SH:gsub('__APP_FILE__', (app:gsub('%%', '%%%%')))):gsub('__CONFIG_FILE__', (config:gsub('%%', '%%%%')))
      cmd = { 'bash', tmp }
    end
    local f = io.open(tmp, 'wb')
    if not f then
      local msg = '无法写入临时脚本: ' .. tmp
      vim.notify(msg, vim.log.levels.ERROR)
      return require('utils.overseer_util').fail_task('环境切换', msg)
    end
    f:write(script)
    f:close()
    return {
      cmd = cmd,
      cwd = root,
      name = '环境切换',
      components = { 'default', 'env_switch_reload' },
      metadata = { files = { app, config } },
    }
  end,
  condition = {
    callback = function(opts)
      local cwd = opts and opts.cwd or vim.fn.getcwd()
      return M.find_root(cwd) ~= nil
    end,
  },
}
