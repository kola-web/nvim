-- package.json scripts picker
-- 从 cwd 向上找 package.json → 列出 scripts → 回车用 overseer 跑 pnpm run <script>
-- <leader>xn 触发

local util = require('utils.overseer_util')
local overseer = require('overseer')

local M = {}

--- 从 cwd 向上找 package.json
--- @return string|nil root 项目根目录
--- @return string|nil path package.json 完整路径
local function find_package_json()
  local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
  local seen = {}
  while dir and dir ~= '' and not seen[dir] do
    seen[dir] = true
    local p = vim.fs.joinpath(dir, 'package.json')
    if vim.fn.filereadable(p) == 1 then
      return dir, p
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      break
    end
    dir = parent
  end
  return nil
end

function M.picker()
  local root, pkg_path = find_package_json()
  if not root then
    vim.notify('[scripts picker] 从 ' .. vim.fn.getcwd() .. ' 向上未找到 package.json', vim.log.levels.WARN)
    return
  end

  local ok, data = pcall(vim.fn.json_decode, vim.fn.readfile(pkg_path))
  if not ok or type(data) ~= 'table' or type(data.scripts) ~= 'table' then
    vim.notify('[scripts picker] package.json 中没有 scripts', vim.log.levels.WARN)
    return
  end

  -- 构造 picker items（text = 脚本名，preview = 命令内容）
  local items = {}
  for name, cmd in pairs(data.scripts) do
    table.insert(items, {
      text = name,
      preview = tostring(cmd),
      root = root,
    })
  end
  table.sort(items, function(a, b) return a.text < b.text end)

  Snacks.picker({
    title = 'npm scripts',
    items = items,
    layout = { preset = 'ivy' },
    on_show = function()
      vim.cmd.stopinsert()
    end,
    format = function(item)
      return {
        { item.text .. '  ', 'SnacksPickerLabel' },
        { item.preview, 'Comment' },
      }
    end,
    confirm = function(item)
      local script = item.text
      local is_win = vim.fn.has('win32') == 1
      local cmd = is_win
        and vim.list_extend(util.pwsh(), { '-Command', 'pnpm run ' .. script })
        or { 'pnpm', 'run', script }
      overseer.new_task({
        name = 'pnpm ' .. script,
        cmd = cmd,
        cwd = item.root,
        components = {
          'default',
          { 'on_complete_notify', statuses = { 'FAILURE' } },
        },
      }):start()
    end,
  })
end

vim.keymap.set('n', '<leader>xn', M.picker, { desc = 'Overseer: package.json scripts' })

return M
