vim.pack.add({
  'https://github.com/romgrk/barbar.nvim',
})

vim.o.showtabline = 2
vim.g.barbar_auto_setup = false

require('barbar').setup({
  animation = false,
  tabpages = true,
  clickable = false,
  sidebar_filetypes = {},
  auto_hide = false,
  minimum_padding = 0,
  maximum_padding = 1,
  maximum_length = 20, -- buffer名字最大长度，避免占满屏幕
  no_name_title = ' ',
  exclude_name = { '' }, -- 隐藏空的无名 buffer（Ctrl+O 跳到失效位置时 Vim 会新建）
  exclude_ft = {
    'qf',
    'git',
    'trouble',
    'toggleterm',
    'NvimTree',
    'help',
    'man',
  },
})

vim.keymap.set('n', '<S-tab>', '<cmd>BufferPrevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<tab>', '<cmd>BufferNext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '(', '<cmd>BufferMovePrevious<cr>', { desc = 'move prev' })
vim.keymap.set('n', ')', '<cmd>BufferMoveNext<cr>', { desc = 'move move' })
vim.keymap.set('n', '<leader>br', '<cmd>BufferRestore<cr>', { desc = 'Restore buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Toggle Pin' })

-- 清理跳转（Ctrl+O/Ctrl+I）产生/残留的空无名 buffer：离开后自动删除
-- 仅针对：无名 + 已列出 + 普通文件类型 + 未修改，避免误删正常缓冲

-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = vim.api.nvim_create_augroup('kola_clean_empty_buf', { clear = true }),
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     vim.schedule(function()
--       if vim.api.nvim_get_current_buf() == buf then
--         return
--       end
--       if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
--         return
--       end
--       local is_unnamed = vim.api.nvim_buf_get_name(buf) == ''
--       local is_plain = vim.bo[buf].buflisted and vim.bo[buf].buftype == '' and not vim.bo[buf].modified
--       if is_unnamed and is_plain then
--         vim.api.nvim_buf_delete(buf, { force = true })
--       end
--     end)
--   end,
-- })
