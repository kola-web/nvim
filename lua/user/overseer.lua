vim.pack.add({
  'https://github.com/stevearc/overseer.nvim',
})

local overseer = require('overseer')
overseer.setup({
  dap = false,
  task_list = {
    bindings = {
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
      ['oo'] = '<cmd>OverseerQuickAction restart<cr>',
    },
  },
  form = {
    win_opts = {
      winblend = 0,
    },
  },
  confirm = {
    win_opts = {
      winblend = 0,
    },
  },
  task_win = {
    win_opts = {
      winblend = 0,
    },
  },
  templates = { 'builtin', 'user.run_script' },
})

vim.keymap.set('n', '<leader>ow', '<cmd>OverseerToggle<cr>', { desc = 'Task list' })
vim.keymap.set('n', '<leader>oo', '<cmd>OverseerRun<cr>', { desc = 'Run task' })
vim.keymap.set('n', '<leader>oq', '<cmd>OverseerQuickAction<cr>', { desc = 'Action recent task' })
vim.keymap.set('n', '<leader>oi', '<cmd>OverseerInfo<cr>', { desc = 'Overseer Info' })
vim.keymap.set('n', '<leader>ob', '<cmd>OverseerBuild<cr>', { desc = 'Task builder' })
vim.keymap.set('n', '<leader>ot', '<cmd>OverseerTaskAction<cr>', { desc = 'Task action' })
vim.keymap.set('n', '<leader>oc', '<cmd>OverseerClearCache<cr>', { desc = 'Clear cache' })
