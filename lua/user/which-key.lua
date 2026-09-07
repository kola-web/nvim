vim.pack.add({
  'https://github.com/folke/which-key.nvim',
})

local which_key_ok, which_key = pcall(require, 'which-key')
if which_key_ok then
  which_key.setup({
    preset = 'helix',
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs', icon = { icon = '󰓩 ', color = 'orange' } },
        { '<leader>a', group = 'ai', icon = { icon = ' ', color = 'purple' } },
        { '<leader>b', group = 'buffer', icon = { icon = ' ', color = 'blue' } },
        { '<leader>c', group = 'close', icon = { icon = '󰅖 ', color = 'red' } },
        { '<leader>d', group = 'debug', icon = { icon = ' ', color = 'red' } },
        { '<leader>e', group = 'explorer', icon = { icon = '󰉋 ', color = 'blue' } },
        { '<leader>f', group = 'files', icon = { icon = '󰈞 ', color = 'blue' } },
        { '<leader>z', group = 'zen', icon = { icon = '󰇼 ', color = 'green' } },
        { '<leader>h', group = 'view', icon = { icon = '󰍉 ', color = 'orange' } },
        { '<leader>o', group = 'open', icon = { icon = '󰌌 ', color = 'green' } },
        { '<leader>v', group = 'tools', icon = { icon = '󰧨 ', color = 'purple' } },
        { '<leader>u', group = 'update', icon = { icon = '󰕌 ', color = 'green' } },
        { '<leader>;', group = 'dropbar', icon = { icon = '󰨇 ', color = 'purple' } },
        { '<leader>g', group = 'git', icon = { icon = '󰊢 ', color = 'orange' } },
        { '<leader>s', group = 'search', icon = { icon = ' ', color = 'blue' } },
        { '<leader>x', group = 'task', icon = { icon = '󱖫 ', color = 'green' } },
        { '<leader>t', group = 'todo', icon = { icon = '󱖫 ', color = 'yellow' } },
        { '<leader>xw', group = 'wechat', icon = { icon = '󰘘 ', color = 'green' } },
        { '<leader>xp', group = 'project', icon = { icon = '󰈺 ', color = 'blue' } },
        { '<leader>l', group = 'lsp', icon = { icon = ' ', color = 'cyan' } },
        { '<leader>L', group = 'restart', icon = { icon = '󰔄 ', color = 'orange' } },
        { '<leader>n', group = 'notification', icon = { icon = ' ', color = 'yellow' } },
        { '<leader>p', group = 'session', icon = { icon = ' ', color = 'purple' } },
        { '<leader>r', group = 'transform', icon = { icon = ' ', color = 'orange' } },
        { '<leader>q', group = 'quick', icon = { icon = '󰅶 ', color = 'purple' } },
        { '<leader>P', group = 'pack', icon = { icon = '󰏗 ', color = 'orange' } },
        { '[', group = 'prev', icon = { icon = '󰮳 ', color = 'blue' } },
        { ']', group = 'next', icon = { icon = '󰮱 ', color = 'blue' } },
        { 'g', group = 'goto' },
        { 'z', group = 'fold' },
      },
    },
  })
end
