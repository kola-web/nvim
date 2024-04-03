local M = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  keys = {
    { 'K', '<cmd>Lspsaga hover_doc<cr>', desc = 'hover_doc', mode = { 'n' } },
    { 'gd', '<cmd>Lspsaga goto_definition<cr>', desc = 'goto_definition', mode = { 'n' } },
    { 'gD', '<cmd>Lspsaga goto_type_definition<cr>', desc = 'goto_type_definition', mode = { 'n' } },
    { 'gr', '<cmd>Lspsaga finder ++normal<cr>', desc = 'finder', mode = { 'n' } },
    { 'gi', '<cmd>Lspsaga finder imp ++normal<cr>', desc = 'imp', mode = { 'n' } },
    { 'gp', '<cmd>Lspsaga peek_definition<cr>', desc = 'peek_definition', mode = { 'n' } },
    { 'gP', '<cmd>Lspsaga peek_type_definition<cr>', desc = 'peek_type_definition', mode = { 'n' } },
    { 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', desc = 'show_line_diagnostics', mode = { 'n' } },
    { '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = 'diagnostic_jump_prev', mode = { 'n' } },
    { ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = 'diagnostic_jump_next', mode = { 'n' } },
    {
      '[e',
      function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      desc = 'diagnostic_jump_prev Error',
      mode = { 'n' },
    },
    {
      ']e',
      function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      desc = 'diagnostic_jump_next Error',
      mode = { 'n' },
    },
    {
      '[w',
      function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.WARN })
      end,
      desc = 'diagnostic_jump_prev Error',
      mode = { 'n' },
    },
    {
      ']w',
      function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.WARN })
      end,
      desc = 'diagnostic_jump_next Error',
      mode = { 'n' },
    },
    { '<leader>o', '<cmd>Lspsaga outline<cr>', desc = 'outline', mode = { 'n' } },
    { '<leader>la', '<cmd>Lspsaga code_action<cr>', desc = 'code_action', mode = { 'n' } },
    { '<leader>ld', '<cmd>Lspsaga show_buf_diagnostics ++normal<cr>', desc = 'code_action', mode = { 'n' } },
    { '<leader>lD', '<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>', desc = 'code_action', mode = { 'n' } },
    { '<leader>li', '<cmd>Lspsaga incoming_calls<cr>', desc = 'incoming_calls', mode = { 'n' } },
    { '<leader>lo', '<cmd>Lspsaga outgoing_calls<cr>', desc = 'outgoing_calls', mode = { 'n' } },
    { '<leader>lr', '<cmd>Lspsaga rename<cr>', desc = 'rename', mode = { 'n' } },
  },
  opts = {
    symbol_in_winbar = {
      folder_level = 1,
    },
    lightbulb = {
      sign = false,
    },
    outline = {
      layout = 'float',
      keys = {
        toggle_or_jump = '<cr>',
      },
    },
    finder = {
      keys = {
        shuttle = '<C-w>',
      },
    },
    diagnostic = {
      keys = {
        quit = { 'q' },
        quit_in_show = { 'q' },
      },
    },
  },
}

return M
