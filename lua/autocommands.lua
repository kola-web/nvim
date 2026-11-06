local function augroup(name)
  return vim.api.nvim_create_augroup('kola_' .. name, { clear = true })
end

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then
      output = 'No output from build command.'
    end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- This autocommand runs after a plugin is installed or updated and
--  runs the appropriate build command for that plugin if necessary.
--
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'LuaSnip' then
      if vim.fn.has('win32') ~= 1 and vim.fn.executable('make') == 1 then
        run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
      end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
      return
    end

    if name == 'peek.nvim' and (kind == 'install' or kind == 'update') then
      local result = vim.system({ 'deno', 'task', '--quiet', 'build:fast' }, { cwd = ev.data.path }):wait()

      if result.code ~= 0 then
        vim.notify('Failed to build peek.nvim:\n' .. result.stderr, vim.log.levels.ERROR)
      end
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('HighlightYank'),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- 禁止新行注释
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('NewLineComment'),
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Disable New Line Comment',
})

-- File type specific settings
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = augroup('AutoHotkeyComment'),
  pattern = { '*.ahk', '*.ahk2' },
  callback = function()
    vim.bo.commentstring = '; %s'
    vim.bo.comments = 's1:/*,mb:*,ex:*/,:;'
  end,
})

-- 切换session后删除所有buffer
vim.api.nvim_create_autocmd({ 'User' }, {
  group = augroup('Session'),
  pattern = { 'PersistenceLoadPre' },
  callback = function()
    Snacks.bufdelete.all()
  end,
})

-- markdown conceal
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('markdown_conceal'),
  pattern = { 'markdown' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- q 关闭各类功能窗格（quickfix / help / 插件浮窗列表等）
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('EasyQuit'),
  pattern = {
    'qf', 'help', 'man', 'notify', 'nofile', 'lspinfo', 'lazy', 'mason',
    'checkhealth', 'null-ls-info', 'oil', 'aerial', 'Trouble', 'trouble',
    'OverseerList', 'kulala', 'NvimTree', 'neo-tree', 'undotree',
    'gitcommit', 'startuptime', 'fugitive', 'vimfiler',
  },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, silent = true, desc = 'Close window' })
  end,
})

-- diff 模式下给两侧窗口加 winbar 标签，区分“当前文件”和“对比内容”
vim.api.nvim_set_hl(0, 'DiffLabelCurrent', { bg = '#1f3d2b', fg = '#86d6a8', bold = true })
vim.api.nvim_set_hl(0, 'DiffLabelOther', { bg = '#3d2f1f', fg = '#d6a886', bold = true })

local function label_diff_windows()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local diff_wins = {}
  for _, w in ipairs(wins) do
    if vim.wo[w].diff then
      table.insert(diff_wins, w)
    end
  end
  if #diff_wins < 2 then
    return
  end
  if vim.wo[diff_wins[1]].winbar:find('DiffLabelCurrent', 1, true) then
    return
  end

  local vertical = vim.fn.winwidth(diff_wins[1]) ~= vim.o.columns
  table.sort(diff_wins, function(a, b)
    local ia = vim.api.nvim_win_get_position(a)
    local ib = vim.api.nvim_win_get_position(b)
    if vertical then
      return ia[2] < ib[2]
    end
    return ia[1] < ib[1]
  end)

  vim.wo[diff_wins[1]].winbar = '%#DiffLabelCurrent#  [当前文件] %t%*'
  for i = 2, #diff_wins do
    vim.wo[diff_wins[i]].winbar = '%#DiffLabelOther#  [对比] %t%*'
  end
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'User' }, {
  group = augroup('DiffLabels'),
  pattern = { '*', 'DiffUpdated' },
  callback = label_diff_windows,
})
