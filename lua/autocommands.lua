local function augroup(name)
  return vim.api.nvim_create_augroup('kola_' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'sagadiagnostc',
    'dropbar_menu',
    'lazy',
    'noice',
    'DressingSelect',
    'codecompanion',
    'DiffviewFiles',
    'grug-far',
    'rest_nvim_result',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.bo[event.buf].buflisted = false
        vim.cmd('close')
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- 禁止新行注释
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Disable New Line Comment',
})

-- File type specific settings
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('AutoHotkeyComment', {}),
  pattern = { '*.ahk', '*.ahk2' },
  callback = function()
    vim.bo.commentstring = '; %s'
    vim.bo.comments = 's1:/*,mb:*,ex:*/,:;'
  end,
})

-- 切换session后删除所有buffer
vim.api.nvim_create_autocmd({ 'User' }, {
  group = augroup('session'),
  pattern = { 'PersistenceLoadPre' },
  callback = function()
    Snacks.bufdelete.all()
  end,
})

-- 修复cmdline windows <cr>被全局映射覆盖的问题
-- vim.api.nvim_create_autocmd('CmdwinEnter', {
--   group = augroup('set_default_cr'),
--   callback = function()
--     vim.keymap.set('n', '<cr>', '<cr>', { buffer = 0, noremap = true })
--   end,
-- })
-- vim.api.nvim_create_autocmd('FileType', {
--   group = augroup('set_default_cr'),
--   pattern = {
--     'qf',
--     'vim',
--   },
--   callback = function(event)
--     vim.keymap.set('n', '<cr>', '<cr>', { buffer = 0, noremap = true })
--   end,
-- })
