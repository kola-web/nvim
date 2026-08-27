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
  templates = {
    'builtin',
    'user.run_script',
    'user.wx_preview',
    'user.wx_upload',
    'user.wx_open',
    'user.wx_npm',
    'user.wx_ci_upload',
  },
})

vim.keymap.set('n', '<leader>tw', '<cmd>OverseerToggle<cr>', { desc = 'Task list' })
vim.keymap.set('n', '<leader>to', '<cmd>OverseerRun<cr>', { desc = 'Run task' })
vim.keymap.set('n', '<leader>tq', '<cmd>OverseerQuickAction<cr>', { desc = 'Action recent task' })
vim.keymap.set('n', '<leader>ti', '<cmd>OverseerInfo<cr>', { desc = 'Overseer Info' })
vim.keymap.set('n', '<leader>tb', '<cmd>OverseerBuild<cr>', { desc = 'Task builder' })
vim.keymap.set('n', '<leader>tt', '<cmd>OverseerTaskAction<cr>', { desc = 'Task action' })
vim.keymap.set('n', '<leader>td', '<cmd>OverseerClearCache<cr>', { desc = 'Clear cache' })

-- 微信小程序（需在开发者工具「设置-安全设置」开启服务端口；登录一次）
vim.keymap.set('n', '<leader>txp', function() require('overseer').run_task({ name = 'wx preview' }) end, { desc = 'WX 生成预览二维码' })
vim.keymap.set('n', '<leader>txu', function() require('overseer').run_task({ name = 'wx upload' }) end, { desc = 'WX 上传体验版' })
vim.keymap.set('n', '<leader>txg', function() require('overseer').run_task({ name = 'wx open' }) end, { desc = 'WX 打开到开发者工具' })
vim.keymap.set('n', '<leader>txn', function() require('overseer').run_task({ name = 'wx build-npm' }) end, { desc = 'WX 构建 npm' })
vim.keymap.set('n', '<leader>txc', function() require('overseer').run_task({ name = 'wx ci upload' }) end, { desc = 'WX miniprogram-ci 上传' })
