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
    -- { 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', mode = { 'n' } },
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
}

return M
