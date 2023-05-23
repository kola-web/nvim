-- local keymap = vim.keymap.set
--
-- vim.g.codeium_disable_bindings = 1
--
-- keymap('i', '<Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
-- keymap('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
-- keymap('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
-- keymap('i', '<c-]>', function() return vim.fn['codeium#Clear']() end, { expr = true })
--
-- vim.g.codeium_filetypes = {
--   bash=false
-- }

local status, codeium = pcall(require, "codeium")
if not status then
  return
end

codeium.setup()
