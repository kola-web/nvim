require('mini.files').setup({
  windows = {
    preview = false,
    width_focus = 30,
    width_preview = 30,
  },
  mappings = {
    go_in = 'L',
    go_in_plus = 'l',
    go_out = 'H',
    go_out_plus = 'h',
    synchronize = '<cr>',
  },
  content = {
    sort = function(entries)
      local function compare_alphanumerically(e1, e2)
        -- Put directories first.
        if e1.is_dir and not e2.is_dir then
          return true
        end
        if not e1.is_dir and e2.is_dir then
          return false
        end
        -- Order numerically based on digits if the text before them is equal.
        if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
          return e1.digits < e2.digits
        end
        -- Otherwise order alphabetically ignoring case.
        return e1.lower_name < e2.lower_name
      end

      local sorted = vim.tbl_map(function(entry)
        local pre_digits, digits = entry.name:match('^(%D*)(%d+)')
        if digits ~= nil then
          digits = tonumber(digits)
        end

        return {
          fs_type = entry.fs_type,
          name = entry.name,
          path = entry.path,
          lower_name = entry.name:lower(),
          is_dir = entry.fs_type == 'directory',
          pre_digits = pre_digits,
          digits = digits,
        }
      end, entries)
      table.sort(sorted, compare_alphanumerically)
      -- Keep only the necessary fields.
      return vim.tbl_map(function(x)
        return { name = x.name, fs_type = x.fs_type, path = x.path }
      end, sorted)
    end,
  },
})

local copy_file_path = require('utils.init').copy_file_path
local add_to_gitignore = require('utils.init').add_to_gitignore
local show_dotfiles = true
local filter_show = function(fs_entry)
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  require('mini.files').refresh({ content = { filter = new_filter } })
end

local map_split = function(buf_id, lhs, direction, close_on_file)
  local rhs = function()
    local new_target_window
    local cur_target_window = require('mini.files').get_explorer_state().target_window
    if cur_target_window ~= nil then
      vim.api.nvim_win_call(cur_target_window, function()
        vim.cmd('belowright ' .. direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)

      require('mini.files').set_target_window(new_target_window)
      require('mini.files').go_in({ close_on_file = close_on_file })
    end
  end

  local desc = 'Open in ' .. direction .. ' split'
  if close_on_file then
    desc = desc .. ' and close'
  end
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

local files_set_cwd = function()
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  if cur_directory ~= nil then
    vim.fn.chdir(cur_directory)
  end
end

local files_grug_far_replace = function(path)
  -- works only if cursor is on the valid file system entry
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local prefills = { paths = vim.fs.dirname(cur_entry_path) }

  local grug_far = require('grug-far')

  -- instance check
  if not grug_far.has_instance('explorer') then
    grug_far.open({
      instanceName = 'explorer',
      prefills = prefills,
      staticTitle = 'Find and Replace from Explorer',
    })
  else
    grug_far.get_instance('explorer'):open()
    -- updating the prefills without crealing the search and other fields
    grug_far.get_instance('explorer'):update_input_values(prefills, false)
  end
end

-- ============================================================
-- 跨实例剪贴板: cy 复制 / cx 剪切 / cp 粘贴 / cs 粘贴为符号链接
-- 原理: 路径写入共享状态文件, 任何 nvim 实例都可读取,
--       不依赖寄存器(寄存器是单实例的), 也不怕系统剪贴板被覆盖
-- 键位: cy(复制) cx(剪切) cp(粘贴到当前目录/光标所在目录)
--       cs(粘贴为指向源文件/目录的链接, 跨项目引用; Windows 目录走 junction, 免开发者模式)
-- ============================================================
local XCLIP_FILE = vim.fn.stdpath('state') .. '/minifiles-cross-clipboard.txt'

local function xclip_write(mode)
  local entry = MiniFiles.get_fs_entry()
  if entry == nil or entry.name == '..' or (entry.fs_type ~= 'file' and entry.fs_type ~= 'directory') then
    vim.notify('mini.files: 请将光标放在要操作的文件/目录上', vim.log.levels.WARN)
    return
  end
  local ok, err = pcall(vim.fn.writefile, { mode, entry.path }, XCLIP_FILE)
  if not ok then
    vim.notify('mini.files: 写入跨实例剪贴板失败: ' .. tostring(err), vim.log.levels.ERROR)
    return
  end
  vim.fn.setreg('+', entry.path)
  vim.notify(('mini.files: 已%s %s'):format(mode == 'cut' and '剪切' or '复制', entry.path), vim.log.levels.INFO)
end

local function xclip_read()
  local ok, lines = pcall(vim.fn.readfile, XCLIP_FILE)
  if not ok or #lines < 2 or lines[1] == '' or lines[2] == '' then
    local reg = vim.fn.getreg('+')
    if reg ~= '' then
      return 'copy', vim.split(reg, '\n')[1]
    end
    vim.notify('mini.files: 跨实例剪贴板为空', vim.log.levels.WARN)
    return nil
  end
  return (lines[1] == 'cut' and 'cut' or 'copy'), lines[2]
end

local function xclip_delete(p)
  -- 用 lstat(不跟随链接): 符号链接只删链接本身, 绝不能递归删到链接指向的目标
  local stat = vim.loop.fs_lstat(p)
  if stat == nil then return end
  if stat.type == 'link' or stat.type == 'file' then
    -- Windows 的目录 junction / 目录符号链接属于"目录型 reparse point",
    -- fs_unlink(DeleteFileW) 删不掉, 需要 fs_rmdir(RemoveDirectoryW) —— 只移除链接本身
    if vim.loop.fs_unlink(p) ~= true and vim.loop.fs_lstat(p) ~= nil then
      vim.loop.fs_rmdir(p)
    end
  elseif stat.type == 'directory' then
    for entry, _ in vim.fs.dir(p, { hidden = true }) do
      xclip_delete(vim.fs.joinpath(p, entry))
    end
    vim.loop.fs_rmdir(p)
  end
end

local function xclip_copy(src, dst)
  local stat = vim.loop.fs_stat(src)
  if stat == nil then return false end
  if stat.type == 'file' then
    return vim.loop.fs_copyfile(src, dst) == true
  elseif stat.type == 'directory' then
    vim.loop.fs_mkdir(dst, 493)
    for entry, etype in vim.fs.dir(src, { hidden = true }) do
      local s, d = vim.fs.joinpath(src, entry), vim.fs.joinpath(dst, entry)
      if etype == 'directory' then
        if not xclip_copy(s, d) then return false end
      elseif vim.loop.fs_copyfile(s, d) ~= true then
        return false
      end
    end
    return true
  end
  return false
end

local function xclip_paste()
  local mode, src = xclip_read()
  if mode == nil then return end
  local entry = MiniFiles.get_fs_entry()
  local target_dir
  if entry ~= nil and entry.fs_type == 'directory' and entry.name ~= '..' then
    -- 光标停在文件夹上: 粘贴到与该文件夹同级(父目录), 而不是文件夹内部
    target_dir = vim.fs.dirname(entry.path)
  else
    local state = MiniFiles.get_explorer_state()
    local cur_win = vim.api.nvim_get_current_win()
    if state ~= nil and state.windows ~= nil then
      for _, w in ipairs(state.windows) do
        if w.win_id == cur_win then target_dir = w.path break end
      end
    end
  end
  if target_dir == nil then
    vim.notify('mini.files: 无法确定粘贴目标目录', vim.log.levels.WARN)
    return
  end
  local name = vim.fn.fnamemodify(src, ':t')
  local dst = vim.fs.joinpath(target_dir, name)
  if vim.fn.fnamemodify(src, ':p') == vim.fn.fnamemodify(dst, ':p') then
    vim.notify('mini.files: 源和目标相同', vim.log.levels.WARN)
    return
  end
  if vim.loop.fs_stat(dst) ~= nil then
    local choice = vim.fn.confirm(('目标已存在: %s\n覆盖?'):format(name), '&覆盖\n&跳过', 2)
    if choice ~= 1 then
      vim.notify('mini.files: 已取消粘贴', vim.log.levels.INFO)
      return
    end
    xclip_delete(dst)
  end
  local ok
  if mode == 'cut' then
    if vim.fn.rename(src, dst) == 0 then
      ok = true
    else
      ok = xclip_copy(src, dst) and (xclip_delete(src) or true)
    end
  else
    ok = xclip_copy(src, dst)
  end
  if ok then
    vim.notify(('mini.files: 已%s → %s'):format(mode == 'cut' and '移动' or '复制', dst), vim.log.levels.INFO)
    -- 不能用 MiniFiles.refresh(): 其内部 force_update 默认 false,
    -- 对"外部文件系统变化"不会重读目录内容(仅重排窗口), 列表不会更新
    -- synchronize() 强制 force_update=true, 是官方用于同步外部变化的入口
    require('mini.files').synchronize()
  else
    vim.notify('mini.files: 操作失败', vim.log.levels.ERROR)
  end
end

--- 把剪贴板里的源路径, 以符号链接(symlink)方式粘贴到当前目录
--- 跨项目引用同一文件: A 项目 cy 复制 → 到 B 项目按 cs, 即生成指向 A 文件的链接
local function xclip_paste_symlink()
  local mode, src = xclip_read()
  if mode == nil then return end

  local entry = MiniFiles.get_fs_entry()
  local target_dir
  if entry ~= nil and entry.fs_type == 'directory' and entry.name ~= '..' then
    -- 光标停在文件夹上: 链接放到与该文件夹同级(父目录), 而不是文件夹内部
    target_dir = vim.fs.dirname(entry.path)
  else
    local state = MiniFiles.get_explorer_state()
    local cur_win = vim.api.nvim_get_current_win()
    if state ~= nil and state.windows ~= nil then
      for _, w in ipairs(state.windows) do
        if w.win_id == cur_win then target_dir = w.path break end
      end
    end
  end
  if target_dir == nil then
    vim.notify('mini.files: 无法确定目标目录', vim.log.levels.WARN)
    return
  end

  -- 源路径规范化: fnamemodify(':p') 对目录会追加尾斜杠, 去掉它(盘根除外)
  local src_abs = vim.fn.fnamemodify(src, ':p')
  if not src_abs:match('^%a:[/\\]$') and src_abs ~= '/' and src_abs ~= '\\' then
    src_abs = src_abs:gsub('[/\\]+$', '')
  end
  local name = vim.fn.fnamemodify(src_abs, ':t')
  local dst = vim.fs.joinpath(target_dir, name)
  if src_abs == vim.fn.fnamemodify(dst, ':p'):gsub('[/\\]+$', '') then
    vim.notify('mini.files: 源和目标相同', vim.log.levels.WARN)
    return
  end
  local src_stat = vim.loop.fs_stat(src_abs)
  if src_stat == nil then
    vim.notify(('mini.files: 源不存在: %s'):format(src_abs), vim.log.levels.WARN)
    return
  end
  if vim.loop.fs_stat(dst) ~= nil then
    local choice = vim.fn.confirm(('目标已存在: %s\n删除并创建符号链接?'):format(name), '&删除重建\n&跳过', 2)
    if choice ~= 1 then
      vim.notify('mini.files: 已取消', vim.log.levels.INFO)
      return
    end
    xclip_delete(dst)
  end

  -- 创建链接: 文件用普通符号链接; 目录在 Windows 上优先 junction
  -- (junction 不需要开发者模式/管理员权限, 仅限本地卷), 失败再退回普通目录符号链接。
  -- 注意: luv 的 flags 表字段是 dir / junction, 不是数字形式的 { flags = N }
  --       —— 写错会被静默忽略, 目录链接创建失败却不报错(表现为"按了没反应")
  local is_windows = type(jit) == 'table' and jit.os == 'Windows'
  local kinds
  if src_stat.type ~= 'directory' then
    kinds = { 'plain' }
  elseif is_windows then
    kinds = { 'junction', 'dir', 'plain' }
  else
    kinds = { 'dir', 'plain' }
  end

  local created, last_err = false, '未知错误'
  for _, kind in ipairs(kinds) do
    local flags = kind == 'junction' and { junction = true } or (kind == 'dir' and { dir = true }) or nil
    local ok, ret, err
    if flags == nil then
      ok, ret, err = pcall(vim.loop.fs_symlink, src_abs, dst)
    else
      ok, ret, err = pcall(vim.loop.fs_symlink, src_abs, dst, flags)
    end
    -- 同步版返回 true 或 nil + err; 个别情况下失败也可能留下链接, 以 lstat 为准
    if ok and (ret == true or vim.loop.fs_lstat(dst) ~= nil) then
      created = true
      break
    end
    last_err = err or (ok and '创建失败(无错误信息)' or tostring(ret))
  end

  if created then
    vim.fn.setreg('+', src_abs)
    vim.notify(('mini.files: 已创建链接\n%s → %s'):format(dst, src_abs), vim.log.levels.INFO)
    require('mini.files').synchronize()
  else
    vim.notify(
      ('mini.files: 创建链接失败: %s\n目标: %s'):format(tostring(last_err), dst),
      vim.log.levels.ERROR
    )
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id

    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
    vim.keymap.set('n', 'gc', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })

    map_split(buf_id, '<C-w>s', 'horizontal', false)
    map_split(buf_id, '<C-w>v', 'vertical', false)
    map_split(buf_id, '<C-w>S', 'horizontal', true)
    map_split(buf_id, '<C-w>V', 'vertical', true)

    vim.keymap.set('n', 'wc', require('utils.init').create_mini_component, { buffer = buf_id, desc = '从模板创建小程序组件' })
    vim.keymap.set('n', 'wp', require('utils.init').create_mini_page, { buffer = buf_id, desc = '从模板创建小程序页面' })
    vim.keymap.set('n', '<C-y>', copy_file_path, { buffer = buf_id, desc = 'copy_file_path' })
    vim.keymap.set('n', 'gi', add_to_gitignore, { buffer = buf_id, desc = 'Add to .gitignore' })
    -- insert mode  move corsor right
    vim.keymap.set('i', '<C-f>', '<C-o>l', { buffer = buf_id, desc = 'move cursor right' })
    vim.keymap.set('i', '<C-b>', '<C-o>h', { buffer = buf_id, desc = 'move cursor left' })

    vim.keymap.set('n', 'gs', files_grug_far_replace, { buffer = buf_id, desc = 'Search in directory' })

    vim.keymap.set('n', '_', require('utils.init').openSyatemExplorer, { buffer = buf_id, desc = 'open system explorer' })
    vim.keymap.set('n', '-', require('utils.init').openCurrentSyatemExplorer, { buffer = buf_id, desc = 'open system current explorer' })

    -- 跨实例剪贴板: cy 复制 / cx 剪切 / cp 粘贴 / cs 符号链接粘贴
    vim.keymap.set('n', 'cy', function() xclip_write('copy') end, { buffer = buf_id, desc = '跨实例复制到剪贴板' })
    vim.keymap.set('n', 'cx', function() xclip_write('cut') end, { buffer = buf_id, desc = '跨实例剪切到剪贴板' })
    vim.keymap.set('n', 'cp', xclip_paste, { buffer = buf_id, desc = '从剪贴板跨实例粘贴' })
    vim.keymap.set('n', 'cs', xclip_paste_symlink, { buffer = buf_id, desc = '从剪贴板粘贴为符号链接' })
  end,
})

vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open mini.files (Directory of Current File)' })
vim.keymap.set('n', '<leader>E', function()
  require('mini.files').open(vim.uv.cwd(), true)
end, { desc = 'Open mini.files (Directory of Current File)' })
