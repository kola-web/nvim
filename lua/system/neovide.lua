-- 在 Neovide 中才执行的设置

-- vim.g.neovide_position_animation_length = 0
-- vim.g.neovide_cursor_animation_length = 0.00
-- vim.g.neovide_cursor_trail_size = 0
-- vim.g.neovide_cursor_animate_in_insert_mode = false
-- vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_scroll_animation_far_lines = 0
-- vim.g.neovide_scroll_animation_length = 0.00

vim.g.neovide_detach_on_quit = 'always_quit'

vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
  vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) -- 将剪贴板内容粘贴到 Neovim
end, { noremap = true, silent = true })

vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<C-v>', function()
  vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) -- 将剪贴板内容粘贴到 Neovim
end, { noremap = true, silent = true })
