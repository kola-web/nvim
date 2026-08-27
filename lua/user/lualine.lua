vim.pack.add({
  'https://github.com/nvim-lualine/lualine.nvim',
})

local icons = require('utils.icons')

-- ===== overseer 任务状态：实时显示正在运行 / 刚完成的任务 =====
local last_result = nil -- { name, status, time }，time 为 vim.loop.now() 毫秒
local seen_finished = {} -- 已记录过完成态的任务 id，只捕获"新完成"的任务

local function overseer_status()
  local ok, task_list = pcall(require, 'overseer.task_list')
  if not ok then
    return ''
  end
  local running = task_list.list_tasks({ status = 'RUNNING' })
  if #running > 0 then
    local names = {}
    for _, t in ipairs(running) do
      table.insert(names, t.name)
    end
    return '󰑮 ' .. table.concat(names, ', ')
  end
  if last_result and vim.loop.now() - last_result.time < 5000 then
    local icon_map = { SUCCESS = '󰄴', FAILURE = '󰅚', CANCELED = '' }
    return (icon_map[last_result.status] or '󰅚') .. ' ' .. last_result.name
  end
  return ''
end

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('kola-overseer-status', { clear = true }),
  pattern = 'OverseerListUpdate',
  callback = function()
    local ok, task_list = pcall(require, 'overseer.task_list')
    if ok then
      for _, t in ipairs(task_list.list_tasks({ include_ephemeral = true })) do
        local st = t.status
        if st == 'SUCCESS' or st == 'FAILURE' or st == 'CANCELED' then
          if not seen_finished[t.id] then
            seen_finished[t.id] = true
            last_result = { name = t.name, status = st, time = vim.loop.now() }
          end
        else
          seen_finished[t.id] = nil
        end
      end
    end
    vim.cmd('redrawstatus')
  end,
})

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = true,
    disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diagnostics',
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      {
        'diff',
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
      },
    },
    lualine_c = {
      {
        function()
          return require('utils').get_root_dir()
        end,
        icon = '',
      },
    },
    lualine_x = {
      {
        function()
          return vim.g.aiStatus
        end,
        icon = icons.ai.Ai,
        cond = function()
          return vim.g.aiStatus ~= nil
        end,
      },
      {
        overseer_status,
        cond = function()
          return overseer_status() ~= ''
        end,
      },
      'lsp_status',
      'filetype',
      'filesize',
      {
        'fileformat',
        symbols = {
          unix = 'Unix (LF)',
          dos = 'Windows (CRLF)',
          mac = 'Unix (LF)',
        },
      },
    },
    lualine_y = {
      'progress',
    },
    lualine_z = {
      'location',
    },
  },
  extensions = { 'mason', 'man' },
})
