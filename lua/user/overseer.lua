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
    'user.git_force_reset',
    'user.svn_force_update',
  },
})

-- stylua: ignore start
-- overseer.run_task 在不传 callback 时，模板没匹配上会静默丢掉错误（按了完全没反应）。
-- 统一走这个入口：逼出错误提示，避免「按键不生效但毫无线索」。
local function run(name)
  return function()
    require('overseer').run_task({ name = name }, function(_, err)
      if err then
        vim.notify(('%s：%s'):format(name, err), vim.log.levels.ERROR)
      end
    end)
  end
end

-- overseer 控制（<leader>x + 动作）
vim.keymap.set('n', '<leader>xl', '<cmd>OverseerToggle<cr>',                                            { desc = 'Task list' })
vim.keymap.set('n', '<leader>xo', '<cmd>OverseerRun<cr>',                                               { desc = 'Run task' })
vim.keymap.set('n', '<leader>xa', '<cmd>OverseerTaskAction<cr>',                                        { desc = 'Task action' })
vim.keymap.set('n', '<leader>xc', "<cmd>lua require('overseer').clear_task_cache()<cr>",                { desc = 'Clear cache' })
vim.keymap.set('n', '<leader>xr', run('run script'),                                                   { desc = '运行当前脚本' })
-- 注：overseer 3.x 已移除 OverseerInfo / OverseerQuickAction / OverseerClearCache 命令；
--     Info 无对应命令不再绑键；QuickAction 由 OverseerTaskAction 取代

-- 微信小程序（<leader>xw + 动作；需在开发者工具「设置-安全设置」开启服务端口；登录一次）
vim.keymap.set('n', '<leader>xwp', run('wx preview'),      { desc = 'WX 生成预览二维码' })
vim.keymap.set('n', '<leader>xwu', run('wx upload'),       { desc = 'WX 上传体验版' })
vim.keymap.set('n', '<leader>xwg', run('wx open'),         { desc = 'WX 打开到开发者工具' })
vim.keymap.set('n', '<leader>xwn', run('wx build-npm'),    { desc = 'WX 构建 npm' })
vim.keymap.set('n', '<leader>xwc', run('wx ci upload'),    { desc = 'WX miniprogram-ci 上传' })
vim.keymap.set('n', '<leader>xwe', run('环境切换'),        { desc = '切换 dev/pro 环境' })
vim.keymap.set('n', '<leader>xwd', run('初始化环境配置'),  { desc = '初始化 .env 环境配置' })
vim.keymap.set('n', '<leader>xwi', run('提交图片'),        { desc = '提交图片到服务器（mac: dist.sh / Windows: dist.ps1）' })

-- 项目任务（<leader>xp + 功能）
vim.keymap.set('n', '<leader>xpb', run('打包上线'),        { desc = '打包上线' })
vim.keymap.set('n', '<leader>xpd', run('dev server'),      { desc = '启动 dev server（终端输出）' })
-- stylua: ignore end
