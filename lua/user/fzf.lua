local M = {
  'ibhagwan/fzf-lua',
  enabled = true,
  cmd = 'FzfLua',
  event = 'VeryLazy',
  opts = function()
    local config = require('fzf-lua.config')
    local actions = require('fzf-lua.actions')

    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    -- trouble
    config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open

    return {
      'default-title',
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      defaults = {
        formatter = 'path.dirname_first',
      },
      file_ignore_patterns = { 'node_modules', '.git', 'dist', 'dist_pro', 'dist_uat', '.yarn', 'miniprogram_npm' },
      files = {
        -- previewer = 'bat',
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 1024 * 0.3, -- syntax limit (bytes), 0=nolimit
          limit_b = 1024 * 1024 * 2, -- preview limit (bytes), 0=nolimit
          extensions = {
            ['png'] = { 'viu', '-b' },
            ['jpg'] = { 'viu', '-b' },
            ['jpeg'] = { 'viu', '-b' },
            ['gif'] = { 'viu', '-b' },
            ['webp'] = { 'viu', '-b' },
          },
          ueberzug_scaler = 'fit_contain',
        },
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { '┃', '' },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return 'TroubleIcon' .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. '\t'
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
        },
      },
    }
  end,
  keys = {
    { '<leader>f', '<cmd>FzfLua files<CR>', desc = 'find file' },
    { '<leader>F', '<cmd>FzfLua live_grep<CR>', desc = 'live_grep' },
    {
      '<leader>ss',
      function()
        require('fzf-lua').lsp_document_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = 'Goto Symbol',
    },
    {
      '<leader>sS',
      function()
        require('fzf-lua').lsp_live_workspace_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = 'Goto Symbol (Workspace)',
    },
  },
}

return M
