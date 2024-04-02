local M = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  keys = {
    { '<leader>o', '<cmd>Lspsaga outline<cr>', 'outline', mode = { 'n' } },
  },
  opts = {
    symbol_in_winbar = {
      folder_level = 1,
    },
    outline = {
      layout = 'float',
      keys = {
        toggle_or_jump = '<cr>',
      },
    },
  },
}

return M
