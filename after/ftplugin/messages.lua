-- :message 窗口优化：打开后按 y 直接复制所有消息到剪贴板
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'messages',
  callback = function(args)
    -- y = 复制所有内容到剪贴板
    vim.keymap.set('n', 'y', function()
      vim.cmd('normal! ggvG"+y')
      vim.notify('已复制所有消息到剪贴板', vim.log.levels.INFO)
    end, { buffer = args.buf, desc = 'Copy all messages to clipboard' })
    -- q 关闭（默认就有，这里显式确保）
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, silent = true })
  end,
})
