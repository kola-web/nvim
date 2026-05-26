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
