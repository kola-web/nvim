local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs', icon = { icon = '󰓩 ' } },
        { '<leader>a', group = 'ai', icon = { icon = ' ' } },
        { '<leader>b', group = 'buffer', icon = { icon = ' ' } },
        { '<leader>c', icon = { icon = ' ' } },
        { '<leader>e', icon = { icon = ' ' } },
        { '<leader>f', icon = { icon = '󰈞 ' } },
        { '<leader>j', group = 'splitjoin', icon = { icon = '󰯌 ' } },
        { '<leader>h', icon = { icon = ' ' } },
        { '<leader>o', icon = { icon = '󰙅 ' } },
        { '<leader>u', icon = { icon = '󰕌 ' } },
        { '<leader>;', icon = { icon = '󰨇 ' } },
        { '<leader>i', group = 'run', icon = { icon = ' ' } },
        { '<leader>g', group = 'git', icon = { icon = '󰊢 ' } },
        { '<leader>s', group = 'search', icon = { icon = ' ' } },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        { '<leader>l', group = 'lsp', icon = { icon = ' ' } },
        { '<leader>n', group = 'snippets', icon = { icon = ' ' } },
        { '<leader>p', group = 'peek', icon = { icon = ' ' } },
        { '<leader>r', group = 'transform', icon = { icon = ' ' } },
        { '<leader> ', group = 'flash', icon = { icon = ' ' } },
        { '[', group = 'prev', icon = { icon = '󰮳 ' } },
        { ']', group = 'next', icon = { icon = '󰮱 ' } },
        { 'g', group = 'goto' },
        { 'z', group = 'fold' },
      },
    },
  },
}

return M
