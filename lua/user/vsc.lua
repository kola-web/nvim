local M = {
  {
    'sindrets/diffview.nvim',
    opts = function()
      local act = require('diffview.actions')
      return {
        view = {
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = 'diff3_mixed',
            disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = true, -- See |diffview-config-view.x.winbar_info|
          },
        },
        keymaps = {
          -- disable_defaults = true,
          view = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },

            { 'n', 'x', '<Nop>', { desc = 'nop x' } },
            { 'n', 'xo', act.conflict_choose('ours'), { desc = '选择冲突的 OURS 版本(采用当前更改)' } },
            { 'n', 'xt', act.conflict_choose('theirs'), { desc = '选择冲突的他们的版本(采用传图更改)' } },
            { 'n', 'xb', act.conflict_choose('base'), { desc = '选择冲突的BASE版本(删除冲突部分)' } },
            { 'n', 'xa', act.conflict_choose('all'), { desc = '选择冲突的所有版本(保留双方更改)' } },
          },
          file_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
          file_history_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },
  },
  {
    'mhinz/vim-signify',
    event = 'BufReadPre',
    config = function()
      vim.g.signify_skip = { vcs = { allow = { 'svn' } } }
      vim.g.signify_line_highlight = 0
      vim.g.signify_sign_add = '┃'
      vim.g.signify_sign_delete = '┃'
      vim.g.signify_sign_change = '┃'
    end,
  },
}

return M
