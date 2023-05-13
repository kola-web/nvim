-- local keymap = vim.keymap.set
--
-- vim.g.codeium_disable_bindings = 1
--
-- keymap('i', '<C-e>', function () return vim.fn['codeium#Accept']() end, { expr = true })
-- keymap('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
-- keymap('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
-- keymap('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })

-- vim.g.codeium_filetypes = {
--   bash=false
-- }

local status_ok, codeium = pcall(require, "codeium")
if not status_ok then
  return
end

codeium.setup {}
