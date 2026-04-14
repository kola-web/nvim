local flash_ok, flash = pcall(require, 'flash')
if flash_ok then
  flash.setup({
    modes = {
      char = {
        highlight = { backdrop = false },
      },
    },
    highlight = { backdrop = false },
    label = {
      uppercase = false,
      current = true,
      rainbow = {
        enabled = true,
        shade = 1,
      },
    },
  })
end

vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype

  local exclude_buftypes = { quickfix = true, nofile = true, help = true, prompt = true, terminal = true }
  local exclude_filetypes = { ['TelescopePrompt'] = true, ['snacks_input'] = true }

  if exclude_buftypes[buftype] or exclude_filetypes[filetype] then
    local key = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
    vim.api.nvim_feedkeys(key, 'n', false)
    return
  end

  if flash_ok then
    flash.jump()
  end
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'o', 'x' }, '<S-CR>', function()
  if flash_ok then
    flash.treesitter()
  end
end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function()
  if flash_ok then
    flash.remote()
  end
end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function()
  if flash_ok then
    flash.treesitter_search()
  end
end, { desc = 'Treesitter Search' })
vim.keymap.set('c', '<c-s>', function()
  if flash_ok then
    flash.toggle()
  end
end, { desc = 'Toggle Flash Search' })
