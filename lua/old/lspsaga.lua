local M = {
  'nvimdev/lspsaga.nvim',
  evnet = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  keys = {
    { 'K', '<cmd>Lspsaga hover_doc<cr>', mode = { 'n' } },
    { 'gd', '<cmd>Lspsaga goto_definition<cr>', mode = { 'n' } },
    { 'gD', '<cmd>Lspsaga peek_type_definition<cr>', mode = { 'n' } },
    { 'gr', '<cmd>Lspsaga finder tyd+ref+imp+def<cr>', mode = { 'n' } },
    { 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', mode = { 'n' } },
    { '<leader>la', '<cmd>Lspsaga code_action<cr>', mode = { 'n' } },
    { '<leader>ld', '<cmd>Lspsaga show_buffer_diagnostics<cr>', mode = { 'n' } },
    { '<leader>lD', '<cmd>Lspsaga show_workspace_diagnostics<cr>', mode = { 'n' } },
    { '<leader>li', '<cmd>Lspsaga incoming_calls<cr>', mode = { 'n' } },
    { '<leader>lo', '<cmd>Lspsaga outgoing_calls<cr>', mode = { 'n' } },
    { '<leader>lr', '<cmd>Lspsaga rename<cr>', mode = { 'n' } },
    { '<leader>ld', '<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>', mode = { 'n' } },
    { '<leader>lq', '<cmd>Lspsaga show_buffer_diagnostics ++normal<cr>', mode = { 'n' } },
  },
}

M.config = function()
  require('lspsaga').setup({
    finder = {
      methods = {
        tyd = 'textDocument/typeDefinition',
      },
    },
    diagnostic = {
      extend_relatedInformation = true,
      -- diagnostic_only_current = true,
    },
  })
end

return M
