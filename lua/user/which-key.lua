local which_key_ok, which_key = pcall(require, 'which-key')
if which_key_ok then
  which_key.setup({
    preset = 'helix',
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs', icon = { icon = '󰓩 ' } },
        { '<leader>a', group = 'ai', icon = { icon = ' ' } },
        { '<leader>b', group = 'buffer', icon = { icon = ' ' } },
        { '<leader>c', icon = { icon = ' ' } },
        { '<leader>d', group = 'debug' },
        { '<leader>e', icon = { icon = ' ' } },
        { '<leader>f', icon = { icon = '󰈞 ' } },
        { '<leader>j', group = 'splitjoin', icon = { icon = '󰯌 ' } },
        { '<leader>h', icon = { icon = ' ' } },
        { '<leader>o', icon = { icon = '󰙅 ' } },
        { '<leader>u', icon = { icon = '󰕌 ' } },
        { '<leader>;', group = 'dropbar', icon = { icon = '󰨇 ' } },
        { '<leader>i', group = 'run', icon = { icon = ' ' } },
        { '<leader>g', group = 'git', icon = { icon = '󰊢 ' } },
        { '<leader>s', group = 'search', icon = { icon = ' ' } },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        { '<leader>l', group = 'lsp', icon = { icon = ' ' } },
        { '<leader>L', icon = { icon = ' ' } },
        { '<leader>n', group = 'notification', icon = { icon = ' ' } },
        { '<leader>p', group = 'session', icon = { icon = ' ' } },
        { '<leader>r', group = 'transform', icon = { icon = ' ' } },
        { '<leader>R', group = 'HTTP', icon = { icon = ' ' } },
        { '<leader>q', group = 'peek', icon = { icon = ' ' } },
        { '[', group = 'prev', icon = { icon = '󰮳 ' } },
        { ']', group = 'next', icon = { icon = '󰮱 ' } },
        { 'g', group = 'goto' },
        { 'z', group = 'fold' },
      },
    },
  })
end
