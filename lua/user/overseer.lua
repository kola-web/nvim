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
    'user.deploy',
    'user.image_upload',
    'user.env_switch',
  },
})

-- overseer 控制（<leader>x + 动作）
vim.keymap.set('n', '<leader>xl', '<cmd>OverseerToggle<cr>', { desc = 'Task list' })
vim.keymap.set('n', '<leader>xo', '<cmd>OverseerRun<cr>', { desc = 'Run task' })
vim.keymap.set('n', '<leader>xq', '<cmd>OverseerQuickAction<cr>', { desc = 'Action recent task' })
vim.keymap.set('n', '<leader>xi', '<cmd>OverseerInfo<cr>', { desc = 'Overseer Info' })
vim.keymap.set('n', '<leader>xb', '<cmd>OverseerBuild<cr>', { desc = 'Task builder' })
vim.keymap.set('n', '<leader>xa', '<cmd>OverseerTaskAction<cr>', { desc = 'Task action' })
vim.keymap.set('n', '<leader>xc', '<cmd>OverseerClearCache<cr>', { desc = 'Clear cache' })

-- 微信小程序（<leader>xw + 动作；需在开发者工具「设置-安全设置」开启服务端口；登录一次）
vim.keymap.set('n', '<leader>xwp', function() require('overseer').run_task({ name = 'wx preview' }) end, { desc = 'WX 生成预览二维码' })
vim.keymap.set('n', '<leader>xwu', function() require('overseer').run_task({ name = 'wx upload' }) end, { desc = 'WX 上传体验版' })
vim.keymap.set('n', '<leader>xwg', function() require('overseer').run_task({ name = 'wx open' }) end, { desc = 'WX 打开到开发者工具' })
vim.keymap.set('n', '<leader>xwn', function() require('overseer').run_task({ name = 'wx build-npm' }) end, { desc = 'WX 构建 npm' })
vim.keymap.set('n', '<leader>xwc', function() require('overseer').run_task({ name = 'wx ci upload' }) end, { desc = 'WX miniprogram-ci 上传' })

-- 项目任务（<leader>xp + 功能）
vim.keymap.set('n', '<leader>xpd', function() require('overseer').run_task({ name = '打包上线' }) end, { desc = '打包上线' })
vim.keymap.set('n', '<leader>xpi', function() require('overseer').run_task({ name = '提交图片' }) end, { desc = '提交图片到服务器' })
vim.keymap.set('n', '<leader>xpe', function() require('overseer').run_task({ name = '环境切换' }) end, { desc = '切换 dev/pro 环境' })
