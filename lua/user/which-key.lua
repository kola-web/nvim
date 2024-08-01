local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>a', group = 'ai' },
        { '<leader>b', group = 'buffer' },
        { '<leader>i', group = 'run' },
        { '<leader>g', group = 'git' },
        { '<leader>s', group = 'search' },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        { '<leader>l', group = 'lsp' },
        { '<leader>n', group = 'snippets' },
        { '<leader>p', group = 'peek' },
        { '<leader>r', group = 'transform' },
        { '<leader> ', group = 'flash' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'z', group = 'fold' },
      },
    },
  },
}

return M
