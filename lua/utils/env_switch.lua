-- 小程序环境切换核心逻辑（纯 Lua，Windows / macOS / Linux 行为完全一致）
--
-- 原实现分两条分支：Windows 写 .ps1、其它平台写 .sh。macOS 分支用了 GNU 风格的
-- `sed -i` / `sed -i -E`，而 macOS 自带 BSD sed 要求 `-i` 后必须跟备份后缀，
-- 于是 <leader>xwe 在 mac 上必然报错。这里改成纯 Lua 读写文件，彻底去掉 shell 依赖。
--
-- 规则（与原 PowerShell 版保持一致）：
--   * 从 .env.development / .env.production 读取 APPID / URL / UPFILE_URL / IMAGE_URL
--   * 只改 app.ts / app.js 的 globalData 块内 url / upFileUrl / imageUrl 三个值（值须 https:// 开头）
--   * 同步维护块内的 `// 环境: xxx` 注释
--   * 改 project.config.json 顶层（两空格缩进）appid
--   * 保留原文件的换行风格（LF / CRLF）与末尾换行状态，UTF-8 无 BOM

local M = {}

--- 二进制读文件
--- @param path string
--- @return string|nil
local function read_raw(path)
  local fd = io.open(path, 'rb')
  if not fd then
    return nil
  end
  local s = fd:read('*a')
  fd:close()
  return s
end

--- 二进制写文件（不改变换行，不写 BOM）
local function write_raw(path, s)
  local fd = io.open(path, 'wb')
  if not fd then
    return nil, '无法写入: ' .. path
  end
  fd:write(s)
  fd:close()
  return true
end

--- 按原文件的换行风格切分成行（去掉末尾空行，单独记录是否需要补回末尾换行）
--- @param s string
--- @return string[] lines, string nl, boolean trailing
local function split_lines(s)
  local nl = s:find('\r\n', 1, true) and '\r\n' or '\n'
  local trailing = #s > 0 and s:sub(-#nl) == nl
  local body = trailing and s:sub(1, #s - #nl) or s
  local lines = {}
  for line in (body .. '\n'):gmatch('([^\n]*)\n') do
    lines[#lines + 1] = (line:gsub('\r$', ''))
  end
  return lines, nl, trailing
end

--- @param lines string[]
local function join_lines(lines, nl, trailing)
  return table.concat(lines, nl) .. (trailing and nl or '')
  -- 注意：空文件（lines = {''}）且原本无换行时，上面会得到 ''，符合预期
end

--- 解析 .env 文件
--- @param path string
--- @return table|nil values
--- @return string|nil err
function M.parse_env(path)
  local s = read_raw(path)
  if not s then
    return nil, '缺少环境文件: ' .. path
  end
  local values = {}
  for line in (s .. '\n'):gmatch('([^\n]*)\n') do
    local trimmed = (line:gsub('\r$', ''):gsub('^%s+', ''):gsub('%s+$', ''))
    if trimmed ~= '' and trimmed:sub(1, 1) ~= '#' then
      local k, v = trimmed:match('^([^=]+)=(.*)$')
      if k then
        k = (k:gsub('^%s+', ''):gsub('%s+$', ''))
        v = (v:gsub('^%s+', ''):gsub('%s+$', ''))
        v = (v:gsub('^"(.*)"$', '%1'):gsub("^'(.*)'$", '%1'))
        if k ~= '' then
          values[k] = v
        end
      end
    end
  end
  return values
end

--- 定位 globalData 块（返回起止行号，1-based）
--- @param lines string[]
--- @return integer|nil start_idx
--- @return integer|nil end_idx
local function find_global_data(lines)
  local start_idx
  for i, line in ipairs(lines) do
    if line:match('^%s*globalData%s*:%s*{') then
      start_idx = i
      break
    end
  end
  if not start_idx then
    return nil
  end
  local depth = 0
  for i = start_idx, #lines do
    depth = depth + select(2, lines[i]:gsub('{', '')) - select(2, lines[i]:gsub('}', ''))
    if depth <= 0 then
      return start_idx, i
    end
  end
  return start_idx, #lines
end

--- 在 globalData 块内替换某个键的 https 值（保留缩进与行尾逗号/注释）
local function replace_key(lines, s, e, key, value)
  local pat = "^(%s*)(" .. (key:gsub('%W', '%%%0')) .. "%s*:%s*)'(https://[^']*)'"
  for i = s, e do
    local indent, prefix, old = lines[i]:match(pat)
    if indent then
      local rest = lines[i]:sub(#indent + #prefix + #old + 3)
      lines[i] = indent .. prefix .. "'" .. value .. "'" .. rest
    end
  end
end

--- 块内是否存在 key: 'https://value' 的行
local function has_value(lines, s, e, key, value)
  local pat = "^%s*" .. (key:gsub('%W', '%%%0')) .. "%s*:%s*'"
    .. (value:gsub('%W', '%%%0')) .. "'"
  for i = s, e do
    if lines[i]:match(pat) then
      return true
    end
  end
  return false
end

--- 判断块内 url 当前属于哪个环境
local function detect_env(lines, s, e, url)
  return has_value(lines, s, e, 'url', url)
end

--- 维护块内的环境注释；没有则在第一条 url 之前插入
local function set_env_comment(lines, s, e, indent_hint, env_name)
  for i = s, e do
    local indent = lines[i]:match('^(%s*)//%s*环境:')
    if indent then
      lines[i] = indent .. '// 环境: ' .. env_name
      return
    end
  end
  local insert_at = e
  for i = s, e do
    if lines[i]:match("^%s*url%s*:%s*'") then
      insert_at = i
      break
    end
  end
  table.insert(lines, insert_at, indent_hint .. '// 环境: ' .. env_name)
end

--- 切换环境
--- @param root string 项目根
--- @param app string 入口文件（app.ts / app.js）
--- @param config string project.config.json
--- @param target_env string 'development' | 'production'
--- @return boolean ok
--- @return string[] messages
function M.switch(root, app, config, target_env)
  local msgs = {}
  local function fail(msg)
    msgs[#msgs + 1] = 'ERROR: ' .. msg
    return false, msgs
  end

  local env_path = vim.fs.joinpath(root, '.env.' .. target_env)
  local env, err = M.parse_env(env_path)
  if not env then
    return fail(err)
  end
  if env.APPID == nil or env.APPID == '' then
    return fail(('.env.%s 缺少 APPID'):format(target_env))
  end
  for _, k in ipairs({ 'URL', 'UPFILE_URL', 'IMAGE_URL' }) do
    if env[k] == nil or env[k] == '' then
      return fail(('.env.%s 缺少 %s'):format(target_env, k))
    end
  end

  -- ---- app 文件 ----
  local app_raw = read_raw(app)
  if not app_raw then
    return fail('无法读取入口文件: ' .. app)
  end
  local lines, nl, trailing = split_lines(app_raw)
  local s, e = find_global_data(lines)
  if not s then
    return fail('入口文件里找不到 globalData 块')
  end

  local dev_url = (M.parse_env(vim.fs.joinpath(root, '.env.development')) or {}).URL
  local pro_url = (M.parse_env(vim.fs.joinpath(root, '.env.production')) or {}).URL
  local current = dev_url and detect_env(lines, s, e, dev_url) and 'development'
  if not current and pro_url and detect_env(lines, s, e, pro_url) then
    current = 'production'
  end
  if not current then
    return fail('当前 globalData 的 url 与两个 .env 都不匹配，无法判断环境')
  end
  if current == target_env then
    msgs[#msgs + 1] = ('当前已经是 %s 环境，仅同步配置'):format(target_env)
  else
    msgs[#msgs + 1] = ('环境切换: %s → %s'):format(current, target_env)
  end

  replace_key(lines, s, e, 'url', env.URL)
  replace_key(lines, s, e, 'upFileUrl', env.UPFILE_URL)
  replace_key(lines, s, e, 'imageUrl', env.IMAGE_URL)

  local indent_hint = lines[s + 1] and lines[s + 1]:match('^(%s*)') or '  '
  set_env_comment(lines, s, e, indent_hint, target_env)

  local ok, werr = write_raw(app, join_lines(lines, nl, trailing))
  if not ok then
    return fail(werr)
  end

  -- ---- project.config.json appid ----
  if vim.fn.filereadable(config) == 1 then
    local cfg_raw = read_raw(config)
    if cfg_raw then
      local cfg_lines, cfg_nl, cfg_trailing = split_lines(cfg_raw)
      local changed = false
      for i, line in ipairs(cfg_lines) do
        local prefix, _, suffix = line:match('^(  "appid"%s*:%s*")(wx[^"]*)(".*)$')
        if prefix and suffix then
          cfg_lines[i] = prefix .. env.APPID .. suffix
          changed = true
          break
        end
      end
      if changed then
        local ok2, err2 = write_raw(config, join_lines(cfg_lines, cfg_nl, cfg_trailing))
        if not ok2 then
          return fail(err2)
        end
        msgs[#msgs + 1] = 'project.config.json appid 已更新'
      else
        msgs[#msgs + 1] = 'WARN: project.config.json 未找到顶层两空格缩进的 appid，未改动'
      end
    else
      msgs[#msgs + 1] = 'WARN: project.config.json 读取失败，未改动 appid'
    end
  else
    msgs[#msgs + 1] = 'WARN: 缺少 project.config.json，未改动 appid'
  end

  -- ---- 回读校验 ----
  local verify = read_raw(app)
  local vlines = split_lines(verify or '')
  local vs, ve = find_global_data(vlines)
  local all_ok = vs ~= nil
  for _, pair in ipairs({
    { 'url', env.URL },
    { 'upFileUrl', env.UPFILE_URL },
    { 'imageUrl', env.IMAGE_URL },
  }) do
    if not (vs and has_value(vlines, vs, ve, pair[1], pair[2])) then
      all_ok = false
    end
  end
  if not all_ok then
    return fail('写入后校验失败：globalData 内仍有值未更新')
  end
  msgs[#msgs + 1] = ('校验通过：url / upFileUrl / imageUrl 均为 %s 环境配置'):format(target_env)
  msgs[#msgs + 1] = ('配置文件: %s'):format(vim.fn.fnamemodify(app, ':.'))
  return true, msgs
end

--- 判断当前环境（依据 globalData 里的 url 与 .env 的 URL 是否一致）
--- @param root string
--- @param app string
--- @return string|nil 'development'|'production'
function M.current_env(root, app)
  local raw = read_raw(app)
  if not raw then
    return nil
  end
  local lines = split_lines(raw)
  local s, e = find_global_data(lines)
  if not s then
    return nil
  end
  for _, name in ipairs({ 'development', 'production' }) do
    local env = M.parse_env(vim.fs.joinpath(root, '.env.' .. name))
    if env and env.URL and detect_env(lines, s, e, env.URL) then
      return name
    end
  end
  return nil
end

--- 从 start 目录向上查找项目根（存在 project.config.json）
--- @param start string|nil
--- @return string|nil
function M.find_root(start)
  local dir = start or vim.fn.getcwd()
  while dir and dir ~= '' do
    if vim.fn.filereadable(vim.fs.joinpath(dir, 'project.config.json')) == 1 then
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

--- 自动检测小程序入口文件
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

return M
