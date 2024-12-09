local M = {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  enabled = false,
  opts = {
    'telescope',
    fzf_opts = {
      ['--layout'] = 'default',
      ['--marker'] = '+',
      ['--border'] = 'none',
      ['--padding'] = '0%',
      ['--margin'] = '0%',
      ['--no-separator'] = '',
      ['--preview-window'] = 'up,50%',
      ['--info'] = 'default',
      ['--no-scrollbar'] = true,
    },
    -- fzf_colors = {
    --   ['bg'] = '-1',
    -- },
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
  },
  keys = {
    {
      '<leader>f',
      '<cmd>FzfLua files<CR>',
      desc = 'find file',
    },
  },
}

return M
