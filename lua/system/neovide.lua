-- 在 Neovide 中才执行的设置
vim.g.neovide_scale_factor = 1.4 -- Neovide 的缩放因子
vim.g.neovide_refresh_rate = 60 -- Neovide 的刷新率
vim.g.neovide_cursor_animation_length = 0 -- 关闭光标动画
vim.g.neovide_scroll_animation_length = 0 -- 关闭滚动动画
vim.g.neovide_scroll_animation_far_lines = 0 -- 关闭滚动动画的远距离效果

vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
  vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) -- 将剪贴板内容粘贴到 Neovim
end, { noremap = true, silent = true })

vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<C-v>', function()
  vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) -- 将剪贴板内容粘贴到 Neovim
end, { noremap = true, silent = true })
