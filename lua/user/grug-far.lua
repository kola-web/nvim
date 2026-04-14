local grug_far_ok, grug_far = pcall(require, 'grug-far')
if grug_far_ok then
  grug_far.setup({
    headerMaxWidth = 80,
    engines = {
      ripgrep = {
        extraArgs = '-P',
      },
    },
    keymaps = {
      close = { n = 'q' },
    },
  })
end

vim.keymap.set({ 'n', 'v' }, '<leader>rs', function()
  if grug_far_ok then
    grug_far.open({
      transient = true,
      prefills = {},
    })
  end
end, { desc = 'Search and Replace' })
vim.keymap.set('n', '<leader>ri', function()
  if grug_far_ok then
    grug_far.open({
      transient = true,
      prefills = {
        search = '([\'"])(/images/)(.*?)(\\1)',
        replacement = '$1{{imageUrl}}$3?t={{Timestamp}}$4',
        filesFilter = '*.wxml',
        flags = '-g !src/custom-tab-bar',
      },
    })
  end
end, { desc = 'Replace images' })
