local M = {
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
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
    keys = {
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'DiffviewFileHistory %' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'DiffviewFileHistory' },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffviewOpen' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      current_line_blame = true,
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
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Next Hunk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Prev Hunk')
        map('n', ']H', function()
          gs.nav_hunk('last')
        end, 'Last Hunk')
        map('n', '[H', function()
          gs.nav_hunk('first')
        end, 'First Hunk')
        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>gi', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview Preview Hunk')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
      end,
    },
  },

  {
    'mhinz/vim-signify',
    event = 'BufReadPre',
    config = function()
      vim.g.signify_skip = { vcs = { allow = { 'svn' } } }
      -- vim.g.signify_line_highlight = 0
      -- vim.g.signify_sign_add = '┃'
      -- vim.g.signify_sign_delete = '┃'
      -- vim.g.signify_sign_change = '┃'
      -- vim.g.signify_vcs_cmds = {
      --   svn = 'svn diff % -x -U0 -- %',
      --   svn = 'wsl svn diff --diff-cmd %d -x -U0 -- %f',
      -- }
      -- vim.g.signify_vcs_cmds_diffmode = {
      --   svn = 'wsl svn cat %f',
      -- }
    end,
  },
}

return M
