vim.pack.add({
  'https://github.com/stevearc/overseer.nvim',
})

local overseer = require('overseer')
overseer.setup({
  dap = false,
  task_list = {
    keymaps = {
      ['<C-h>'] = false,
      ['<C-j>'] = false,
      ['<C-k>'] = false,
      ['<C-l>'] = false,
      ['oo'] = { 'keymap.run_action', opts = { action = 'restart' }, desc = 'Restart task' },
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
    'user.dev_server',
  },
})

-- stylua: ignore start
-- overseer 控制（<leader>x + 动作）
vim.keymap.set('n', '<leader>xl', '<cmd>OverseerToggle<cr>',                                            { desc = 'Task list' })
vim.keymap.set('n', '<leader>xo', '<cmd>OverseerRun<cr>',                                               { desc = 'Run task' })
vim.keymap.set('n', '<leader>xq', '<cmd>OverseerTaskAction<cr>',                                        { desc = 'Action on task' })
vim.keymap.set('n', '<leader>xa', '<cmd>OverseerTaskAction<cr>',                                        { desc = 'Task action' })
vim.keymap.set('n', '<leader>xc', "<cmd>lua require('overseer').clear_task_cache()<cr>",                { desc = 'Clear cache' })
vim.keymap.set('n', '<leader>xr', function() require('overseer').run_task({ name = 'run script' }) end, { desc = '运行当前脚本' })
-- 注：overseer 3.x 已移除 OverseerInfo / OverseerQuickAction / OverseerClearCache 命令；
--     Info 无对应命令不再绑键；QuickAction 由 OverseerTaskAction 取代

-- 微信小程序（<leader>xw + 动作；需在开发者工具「设置-安全设置」开启服务端口；登录一次）
vim.keymap.set('n', '<leader>xwp', function() require('overseer').run_task({ name = 'wx preview' }) end,   { desc = 'WX 生成预览二维码' })
vim.keymap.set('n', '<leader>xwu', function() require('overseer').run_task({ name = 'wx upload' }) end,    { desc = 'WX 上传体验版' })
vim.keymap.set('n', '<leader>xwg', function() require('overseer').run_task({ name = 'wx open' }) end,      { desc = 'WX 打开到开发者工具' })
vim.keymap.set('n', '<leader>xwn', function() require('overseer').run_task({ name = 'wx build-npm' }) end, { desc = 'WX 构建 npm' })
vim.keymap.set('n', '<leader>xwc', function() require('overseer').run_task({ name = 'wx ci upload' }) end, { desc = 'WX miniprogram-ci 上传' })
vim.keymap.set('n', '<leader>xwe', function() require('overseer').run_task({ name = '环境切换' }) end,     { desc     = '切换 dev/pro 环境' })

-- 项目任务（<leader>xp + 功能）
vim.keymap.set('n', '<leader>xpb', function() require('overseer').run_task({ name = '打包上线' }) end,   { desc = '打包上线' })
vim.keymap.set('n', '<leader>xpi', function() require('overseer').run_task({ name = '提交图片' }) end,   { desc = '提交图片到服务器' })
vim.keymap.set('n', '<leader>xpd', function() require('overseer').run_task({ name = 'dev server' }) end, { desc = '启动 pnpm dev' })
-- stylua: ignore end
