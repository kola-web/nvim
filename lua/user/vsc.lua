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
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
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
        add = {
          hl = 'GitSignsAdd',
          text = '▎',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        change = {
          hl = 'GitSignsChange',
          text = '▎',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '󰐊',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '󰐊',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsChange',
          text = '▎',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
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
