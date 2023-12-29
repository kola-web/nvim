local M = {
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  keys = {
    { 'K', '<cmd>Lspsaga hover_doc<cr>', mode = { 'n' } },
    { 'gd', '<cmd>Lspsaga goto_definition<cr>', mode = { 'n' } },
    { 'gD', '<cmd>Lspsaga peek_definition<cr>', mode = { 'n' } },
    { 'gr', '<cmd>Lspsaga finder tyd+ref+imp+def<cr>', mode = { 'n' } },
    { 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', mode = { 'n' } },
    { '<leader>o', '<cmd>Lspsaga code_action<cr>', mode = { 'n' } },
    { '<leader>la', '<cmd>Lspsaga code_action<cr>', mode = { 'n' } },
    { '<leader>ld', '<cmd>Lspsaga show_buffer_diagnostics<cr>', mode = { 'n' } },
    { '<leader>lD', '<cmd>Lspsaga show_workspace_diagnostics<cr>', mode = { 'n' } },
    { '<leader>li', '<cmd>Lspsaga incoming_calls<cr>', mode = { 'n' } },
    { '<leader>lo', '<cmd>Lspsaga outgoing_calls<cr>', mode = { 'n' } },
    { '<leader>lr', '<cmd>Lspsaga rename<cr>', mode = { 'n' } },
    { '<leader>lq', '<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>', mode = { 'n' } },
    { '<leader>ld', '<cmd>Lspsaga show_buf_diagnostics ++normal<cr>', mode = { 'n' } },
    { '<leader>lj', '<cmd>Lspsaga diagnostic_jump_next<cr>', mode = { 'n' } },
    { '<leader>lk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', mode = { 'n' } },
  },
  opts = {
    symbol_in_winbar = {
      hide_keyword = true,
      folder_level = 0,
    },
    callhierarchy = {
      keys = {
        shuttle = '<tab>',
      },
    },
    lightbulb = {
      enable = false,
    },
    finder = {
      methods = {
        tyd = 'textDocument/typeDefinition',
      },
      keys = {
        shuttle = '<tab>',
      },
    },
    outline = {
      layout = 'float',
      keys = {
        toggle_or_jump = 'o',
        jump = '<cr>',
      },
    },
    diagnostic = {
      extend_relatedInformation = true,
    },
  },
  config = true,
}

return M
