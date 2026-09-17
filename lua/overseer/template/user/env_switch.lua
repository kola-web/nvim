-- 切换微信小程序环境（dev ↔ pro），通用版（.env 驱动）
--
-- 设计（参考 vue 项目 .env 做法，避免跨项目硬编码）：
--   项目根目录维护两个文件作为配置单一来源：
--     .env.development   APPID/URL/UPFILE_URL/IMAGE_URL
--     .env.production    同上
--   运行一次任务即切到另一个环境（自动检测当前激活环境），并把配置
--   应用到：
--     src/app.ts（或 src/app.js）  → 仅在 globalData 块内替换 url / upFileUrl / imageUrl
--                                    的值（值须以 https:// 开头，绝不触碰 wx.ajax 等
--                                    其他 url: 字段），并同步环境名注释
--     project.config.json          → 顶层 "appid" 替换（condition 下不切换）
--
--   换项目时只需在项目根放好 .env.development / .env.production，本模板零改动。
-- 用法：无参数，运行一次即切到另一个环境（自动检测当前激活环境）
-- 完成后自动刷新已打开的 app.ts / project.config.json buffer 并刷新微信开发者工具
-- （env_switch_reload 组件）

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

-- PowerShell 切换脚本：从 .env.development / .env.production 读取配置并应用
-- （写入临时文件执行，避免引号转义问题）
-- 核心：只处理 globalData 块内的 url/upFileUrl/imageUrl（值以 https:// 开头）
local PW = [==[
$ErrorActionPreference = 'Stop'
$root = '__ROOT__'
$app = '__APP_FILE__'
$config = '__CONFIG_FILE__'

function Parse-Env([string]$path) {
  if (-not (Test-Path $path)) { throw "缺少环境文件: $path" }
  $h = @{}
  foreach ($line in [IO.File]::ReadAllLines($path)) {
    $t = $line.Trim()
    if ($t -eq '' -or $t.StartsWith('#')) { continue }
    $idx = $t.IndexOf('=')
    if ($idx -le 0) { continue }
    $k = $t.Substring(0, $idx).Trim()
    $v = $t.Substring($idx + 1).Trim().Trim('"').Trim("'")
    if ($k -ne '') { $h[$k] = $v }
  }
  return $h
}

$dev = Parse-Env (Join-Path $root '.env.development')
$pro = Parse-Env (Join-Path $root '.env.production')
foreach ($need in @('APPID', 'URL', 'UPFILE_URL', 'IMAGE_URL')) {
  if (-not $dev.ContainsKey($need) -or -not $pro.ContainsKey($need)) {
    Write-Output "[FAIL] .env 缺少必需键: $need（.env.development / .env.production 需含 APPID/URL/UPFILE_URL/IMAGE_URL）"
    exit 1
  }
}

# 读取 app.ts 并按行拆分（保留原行尾）
$content = [IO.File]::ReadAllText($app)
$nl = "`r`n"
if ($content -notmatch "`r`n") { $nl = "`n" }
$lines = $content -split "`r?`n"

# 定位 globalData 块（行区间），只在该块内做替换，避免误改 wx.ajax 等其他 url: 字段
$startIdx = -1
for ($i = 0; $i -lt $lines.Length; $i++) {
  if ($lines[$i] -match '^\s*globalData\s*:\s*\{') { $startIdx = $i; break }
}
if ($startIdx -lt 0) {
  Write-Output '[FAIL] app.ts 未找到 globalData 块'
  exit 1
}
$depth = 0
$endIdx = $lines.Length - 1
for ($i = $startIdx; $i -lt $lines.Length; $i++) {
  $depth += ([regex]::Matches($lines[$i], '\{')).Count
  $depth -= ([regex]::Matches($lines[$i], '\}')).Count
  if ($depth -le 0) { $endIdx = $i; break }
}

# 检测当前激活环境：globalData 块内无注释的 url 行值匹配 dev/pro 的 URL
$cur = $null
for ($i = $startIdx; $i -le $endIdx; $i++) {
  if ($lines[$i] -match ('^\s*url:\s*''' + [regex]::Escape($pro['URL']) + '''')) { $cur = 'pro'; break }
  if ($lines[$i] -match ('^\s*url:\s*''' + [regex]::Escape($dev['URL']) + '''')) { $cur = 'dev'; break }
}
if (-not $cur) {
  Write-Output '[FAIL] 无法识别当前环境（globalData 内未找到激活的 url 行，或与 .env 中 URL 不匹配）'
  exit 1
}

$to = 'dev'
if ($cur -eq 'dev') { $to = 'pro' }
Write-Output "当前环境: $cur"
Write-Output "切换到: $to"
$target = if ($to -eq 'pro') { $pro } else { $dev }
$envName = 'production'
if ($to -eq 'dev') { $envName = 'development' }

# 只在 globalData 块内替换三键值（值须以 https:// 开头）与环境名注释
foreach ($pair in @(
  @{ key = 'url';       env = 'URL' },
  @{ key = 'upFileUrl'; env = 'UPFILE_URL' },
  @{ key = 'imageUrl';  env = 'IMAGE_URL' }
)) {
  $k = $pair.key
  $nv = $target[$pair.env]
  for ($i = $startIdx; $i -le $endIdx; $i++) {
    if ($lines[$i] -match ('^\s*' + $k + ':\s*''https://')) {
      $lines[$i] = [regex]::Replace($lines[$i], ('^(\s*)(' + $k + ':\s*)''[^'']*''([^\r\n]*,)'), ('$1$2''' + $nv + '''$3'))
    }
  }
}
# 环境名注释：块内已存在则替换；不存在则在块内第一个 url 行上方插入
# （保证 url/upFileUrl/imageUrl 上方始终有「// 环境: xxx」，其他项目结构不同也能自动补上）
$hasEnvComment = $false
for ($i = $startIdx; $i -le $endIdx; $i++) {
  if ($lines[$i] -match '^\s*//\s*环境:') { $hasEnvComment = $true; break }
}
if ($hasEnvComment) {
  for ($i = $startIdx; $i -le $endIdx; $i++) {
    if ($lines[$i] -match '^\s*//\s*环境:') {
      $lines[$i] = [regex]::Replace($lines[$i], '^(\s*)//\s*环境:[^\r\n]*', ('$1// 环境: ' + $envName))
    }
  }
} else {
  for ($i = $startIdx; $i -le $endIdx; $i++) {
    if ($lines[$i] -match '^\s*url:\s*''https://') {
      $indent = [regex]::Match($lines[$i], '^\s*').Value
      $newLines = New-Object System.Collections.Generic.List[string]
      for ($j = 0; $j -lt $i; $j++) { $newLines.Add($lines[$j]) }
      $newLines.Add($indent + '// 环境: ' + $envName)
      for ($j = $i; $j -lt $lines.Length; $j++) { $newLines.Add($lines[$j]) }
      $lines = $newLines.ToArray()
      $endIdx = $endIdx + 1
      break
    }
  }
}

# UTF-8 无 BOM 写回（保留原行尾）
[IO.File]::WriteAllText($app, ($lines -join $nl) + $nl, [Text.UTF8Encoding]::new($false))

# 校验 app.ts（块内激活 url 行）
$checkLines = ([IO.File]::ReadAllText($app)) -split "`r?`n"
$ok = $false
for ($i = $startIdx; $i -le $endIdx -and $i -lt $checkLines.Length; $i++) {
  if ($checkLines[$i] -match ('^\s*url:\s*''' + [regex]::Escape($target['URL']) + '''')) { $ok = $true; break }
}
if ($ok) {
  Write-Output ("app.ts 已切换: " + $target['URL'])
} else {
  Write-Output '[FAIL] app.ts 切换后校验未通过'
  exit 1
}

# --- project.config.json：只替换顶层 appid（2 空格缩进；condition 嵌套不匹配） ---
$cfg = [IO.File]::ReadAllText($config)
if ($cfg -notmatch '(?m)^  "appid"\s*:\s*"wx[^"]*"') {
  Write-Output '[FAIL] project.config.json 未找到顶层 appid 字段'
  exit 1
}
$cfg = $cfg -creplace '(?m)^  ("appid"\s*:\s*")wx[^"]*(")', ('  $1' + $target['APPID'] + '$2')
[IO.File]::WriteAllText($config, $cfg, [Text.UTF8Encoding]::new($false))

$cfgCheck = [IO.File]::ReadAllText($config)
if ($cfgCheck -cmatch ('(?m)^  "appid"\s*:\s*"' + [regex]::Escape($target['APPID']) + '"')) {
  Write-Output ("project.config.json appid 已更新: " + $target['APPID'])
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
ROOT="__ROOT__"
APP="__APP_FILE__"
CONFIG="__CONFIG_FILE__"

# sed 正则/替换串转义（. 与 & 特殊；分隔符用 |）
esc_re() { printf '%s' "$1" | sed 's/[.&|]/\\&/g'; }

# 解析 .env：$1=变量前缀  $2=文件
load_env() {
  local pfx="$1" f="$2" line k v
  [ -f "$f" ] || { echo "[FAIL] 缺少环境文件: $f" >&2; exit 1; }
  while IFS= read -r line || [ -n "$line" ]; do
    line=$(printf '%s' "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [ -z "$line" ] && continue
    case "$line" in \#*) continue ;; esac
    k=${line%%=*}
    k=$(printf '%s' "$k" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    v=${line#*=}
    v=$(printf '%s' "$v" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//;s/^[\"']//;s/[\"']$//")
    case "$k" in [A-Za-z_][A-Za-z0-9_]*) eval "${pfx}_$k=\$v" ;; esac
  done < "$f"
}

load_env dev "$ROOT/.env.development"
load_env pro "$ROOT/.env.production"
for k in APPID URL UPFILE_URL IMAGE_URL; do
  eval "dv=\$dev_$k; pv=\$pro_$k"
  [ -n "$dv" ] && [ -n "$pv" ] || { echo "[FAIL] .env 缺少 $k" >&2; exit 1; }
done

# 定位 globalData 块行区间（只在该区间替换，避免误改 wx.ajax 等其他 url: 字段）
gd_line=$(grep -n "^[[:space:]]*globalData[[:space:]]*:[[:space:]]*{" "$APP" | head -1 | cut -d: -f1)
[ -n "$gd_line" ] || { echo "[FAIL] app.ts 未找到 globalData 块" >&2; exit 1; }
end_line=$(awk -v s="$gd_line" 'NR >= s { d += gsub(/\{/,""); d -= gsub(/\}/,""); if (d <= 0) { print NR; exit } }' "$APP")
[ -n "$end_line" ] || end_line=$(wc -l < "$APP")

# 检测当前环境：块内激活 url 行值匹配 dev/pro URL
cur_url=$(sed -n "${gd_line},${end_line}p" "$APP" | grep -m1 -E "^[[:space:]]*url:[[:space:]]*'(https://[^']*)'" | sed "s/.*'\(https:\/\/[^']*\)'.*/\1/")
cur=
[ "$cur_url" = "$pro_URL" ] && cur=pro
[ "$cur_url" = "$dev_URL" ] && cur=dev
[ -n "$cur" ] || { echo "[FAIL] 无法识别当前环境（globalData 内未找到激活 url 行）" >&2; exit 1; }

to=dev
[ "$cur" = dev ] && to=pro
echo "当前环境: $cur"
echo "切换到: $to"

T_URL=$(   [ "$to" = pro ] && echo "$pro_URL"   || echo "$dev_URL" )
T_UP=$(    [ "$to" = pro ] && echo "$pro_UPFILE_URL" || echo "$dev_UPFILE_URL" )
T_IMG=$(   [ "$to" = pro ] && echo "$pro_IMAGE_URL"  || echo "$dev_IMAGE_URL" )
T_APPID=$( [ "$to" = pro ] && echo "$pro_APPID" || echo "$dev_APPID" )
ENV_NAME=production
[ "$to" = dev ] && ENV_NAME=development

# 替换串中的值转义 &（替换串里 & 有特殊含义）
T_URL=$(esc_re "$T_URL"); T_UP=$(esc_re "$T_UP"); T_IMG=$(esc_re "$T_IMG")

# 只在 globalData 块区间内替换三键（值须以 https:// 开头）
sed -i "${gd_line},${end_line}s|^\([[:space:]]*\)\(url:[[:space:]]*\)'https://[^']*'\([^,]*,\)|\1\2'$T_URL'\3|" "$APP"
sed -i "${gd_line},${end_line}s|^\([[:space:]]*\)\(upFileUrl:[[:space:]]*\)'https://[^']*'\([^,]*,\)|\1\2'$T_UP'\3|" "$APP"
sed -i "${gd_line},${end_line}s|^\([[:space:]]*\)\(imageUrl:[[:space:]]*\)'https://[^']*'\([^,]*,\)|\1\2'$T_IMG'\3|" "$APP"

# 环境名注释：块内已存在则替换；不存在则在块内第一个 url 行上方插入
if sed -n "${gd_line},${end_line}p" "$APP" | grep -q "^[[:space:]]*//[[:space:]]*环境:"; then
  sed -i "${gd_line},${end_line}s|^\([[:space:]]*\)//[[:space:]]*环境:[^|]*|\1// 环境: $ENV_NAME|" "$APP"
else
  url_line=$(sed -n "${gd_line},${end_line}p" "$APP" | grep -n "^[[:space:]]*url:[[:space:]]*'https://" | head -1 | cut -d: -f1)
  if [ -n "$url_line" ]; then
    abs=$((gd_line + url_line - 1))
    indent=$(sed -n "${abs}p" "$APP" | sed 's/\(^[[:space:]]*\).*/\1/')
    sed -i "${abs}i\\${indent}// 环境: $ENV_NAME" "$APP"
    end_line=$((end_line + 1))
  fi
fi

# 校验 app.ts（块内激活 url 行）
sed -n "${gd_line},${end_line}p" "$APP" | grep -q "^[[:space:]]*url:[[:space:]]*'$(esc_re "$T_URL")'" || { echo "[FAIL] app.ts 校验未通过" >&2; exit 1; }
echo "app.ts 已切换: $T_URL"

# project.config.json 顶层 appid（condition 嵌套不匹配）
grep -q '^  "appid"[[:space:]]*:[[:space:]]*"wx[^"]*"' "$CONFIG" || { echo "[FAIL] project.config.json 未找到顶层 appid" >&2; exit 1; }
tap=$(esc_re "$T_APPID")
sed -i -E "s|^  (\"appid\"[[:space:]]*:[[:space:]]*\")wx[^\"]*(\")|  \1$tap\2|" "$CONFIG"
grep -q "^  \"appid\"[[:space:]]*:[[:space:]]*\"$T_APPID\"" "$CONFIG" || { echo "[FAIL] project.config.json appid 校验未通过" >&2; exit 1; }
echo "project.config.json appid: $T_APPID"
echo "全部完成"
]==]

local ENV_TEMPLATE = [==[
# 微信小程序环境配置文件（overseer「环境切换」任务配置源）
APPID=在此填写小程序 appid
URL=在此填写接口根地址
UPFILE_URL=在此填写文件上传地址
IMAGE_URL=在此填写图片地址
]==]

return {
  name = '环境切换',
  desc = '按 .env.development / .env.production 切换小程序环境：仅替换 globalData 内 url/upFileUrl/imageUrl + project.config.json appid',
  builder = function()
    local root = M.find_root()
    if not root then
      local msg = '未找到项目根目录（需包含 project.config.json）'
      vim.notify(msg, vim.log.levels.ERROR)
      return require('utils.overseer_util').fail_task('环境切换', msg)
    end
    local app = M.find_app_file(root)
    if not app then
      local msg = '未找到小程序入口文件（src/app.ts、src/app.js、app.ts、app.js）'
      vim.notify(msg, vim.log.levels.ERROR)
      return require('utils.overseer_util').fail_task('环境切换', msg)
    end
    local config = vim.fs.joinpath(root, 'project.config.json')
    local dev_env = vim.fs.joinpath(root, '.env.development')
    local pro_env = vim.fs.joinpath(root, '.env.production')
    for _, f in ipairs({ dev_env, pro_env }) do
      if vim.fn.filereadable(f) ~= 1 then
        local msg = ('缺少 %s\n请在项目根目录创建，格式示例：\n%s'):format(
          vim.fn.fnamemodify(f, ':t'), ENV_TEMPLATE)
        vim.notify(msg, vim.log.levels.ERROR)
        return require('utils.overseer_util').fail_task('环境切换', msg)
      end
    end
    -- 临时脚本放在系统 TEMP（tempname 的文件会在 nvim 退出时被删，任务可能还没跑完）
    local tmp_dir = (vim.fn.has('win32') == 1 and (os.getenv('TEMP') or 'C:/Windows/Temp') or '/tmp')
    local tmp = tmp_dir .. '/env_switch_' .. vim.fn.getpid() .. (vim.fn.has('win32') == 1 and '.ps1' or '.sh')
    local script, cmd
    -- 路径统一为正斜杠，避免 Windows 反斜杠在脚本字符串中的转义问题
    local function sl(p)
      return (p:gsub('\\', '/'))
    end
    if vim.fn.has('win32') == 1 then
      script = (PW:gsub('__ROOT__', sl(root))):gsub('__APP_FILE__', sl(app)):gsub('__CONFIG_FILE__', sl(config))
      cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-File', tmp }
    else
      script = (SH:gsub('__ROOT__', sl(root))):gsub('__APP_FILE__', sl(app)):gsub('__CONFIG_FILE__', sl(config))
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
