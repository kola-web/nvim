local M = {
  {
    'sindrets/diffview.nvim',
    lazy = false,
    opts = function()
      local actions = require('diffview.actions')
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
          disable_defaults = true, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            { 'n', 'x', '<Nop>', { desc = 'nop x' } },
            { 'n', 'xn', actions.select_next_entry, { desc = '打开下一个文件的差异' } },
            { 'n', 'xp', actions.select_prev_entry, { desc = '打开上一个文件的差异' } },
            { 'n', 'xP', actions.select_first_entry, { desc = '打开第一个文件的差异' } },
            { 'n', 'xN', actions.select_last_entry, { desc = '打开最后一个文件的差异' } },
            { 'n', 'gf', actions.goto_file_edit, { desc = '在上一个标签页中打开文件' } },
            { 'n', '<C-w><C-f>', actions.goto_file_split, { desc = '在新分屏中打开文件' } },
            { 'n', '<C-w>gf', actions.goto_file_tab, { desc = '在新标签页中打开文件' } },
            { 'n', 'xe', actions.focus_files, { desc = '将焦点移到文件面板' } },
            { 'n', 'xb', actions.toggle_files, { desc = '切换文件面板' } },
            { 'n', 'g<C-x>', actions.cycle_layout, { desc = '循环浏览可用布局' } },
            { 'n', '[x', actions.prev_conflict, { desc = '在合并工具中：跳转到上一个冲突' } },
            { 'n', ']x', actions.next_conflict, { desc = '在合并工具中：跳转到下一个冲突' } },
            { 'n', 'xo', actions.conflict_choose('ours'), { desc = '选择冲突的OURS版本' } },
            { 'n', 'xt', actions.conflict_choose('theirs'), { desc = '选择冲突的THEIRS版本' } },
            { 'n', 'xb', actions.conflict_choose('base'), { desc = '选择冲突的BASE版本' } },
            { 'n', 'xa', actions.conflict_choose('all'), { desc = '选择冲突的所有版本' } },
            { 'n', 'dx', actions.conflict_choose('none'), { desc = '删除冲突区域' } },
            { 'n', 'xO', actions.conflict_choose_all('ours'), { desc = '为整个文件选择冲突的OURS版本' } },
            { 'n', 'xT', actions.conflict_choose_all('theirs'), { desc = '为整个文件选择冲突的THEIRS版本' } },
            { 'n', 'xB', actions.conflict_choose_all('base'), { desc = '为整个文件选择冲突的BASE版本' } },
            { 'n', 'xA', actions.conflict_choose_all('all'), { desc = '为整个文件选择冲突的所有版本' } },
            { 'n', 'dX', actions.conflict_choose_all('none'), { desc = '删除整个文件的冲突区域' } },
            {
              'n',
              '<cr>',
              function()
                actions.conflict_choose('theirs')()
                actions.next_conflict()
              end,
              { desc = '选择冲突的THEIRS版本,并跳转到下一个冲突' },
            },
            {
              'n',
              '<bs>',
              function()
                actions.conflict_choose('ours')()
                actions.next_conflict()
              end,
              { desc = '选择冲突的OURS版本,并跳转到下一个冲突' },
            },

            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
          diff1 = {
            -- Mappings in single window diff layouts
            { 'n', '?', actions.help({ 'view', 'diff1' }), { desc = '打开帮助面板' } },
          },
          diff2 = {
            -- Mappings in 2-way diff layouts
            { 'n', '?', actions.help({ 'view', 'diff2' }), { desc = '打开帮助面板' } },
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { 'n', 'x' }, '2do', actions.diffget('ours'), { desc = '从文件的OURS版本获取差异块' } },
            { { 'n', 'x' }, '3do', actions.diffget('theirs'), { desc = '从文件的THEIRS版本获取差异块' } },
            { 'n', '?', actions.help({ 'view', 'diff3' }), { desc = '打开帮助面板' } },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { 'n', 'x' }, '1do', actions.diffget('base'), { desc = '从文件的BASE版本获取差异块' } },
            { { 'n', 'x' }, '2do', actions.diffget('ours'), { desc = '从文件的OURS版本获取差异块' } },
            { { 'n', 'x' }, '3do', actions.diffget('theirs'), { desc = '从文件的THEIRS版本获取差异块' } },
            { 'n', '?', actions.help({ 'view', 'diff4' }), { desc = '打开帮助面板' } },
          },
          file_panel = {
            { 'n', 'j', actions.next_entry, { desc = '将光标移到下一个文件条目' } },
            { 'n', '<down>', actions.next_entry, { desc = '将光标移到下一个文件条目' } },
            { 'n', 'k', actions.prev_entry, { desc = '将光标移到上一个文件条目' } },
            { 'n', '<up>', actions.prev_entry, { desc = '将光标移到上一个文件条目' } },
            { 'n', '<cr>', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', 'o', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', 'l', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', '<2-LeftMouse>', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', '-', actions.toggle_stage_entry, { desc = '暂存/取消暂存所选条目' } },
            { 'n', 's', actions.toggle_stage_entry, { desc = '暂存/取消暂存所选条目' } },
            { 'n', 'S', actions.stage_all, { desc = '暂存所有条目' } },
            { 'n', 'U', actions.unstage_all, { desc = '取消暂存所有条目' } },
            { 'n', 'X', actions.restore_entry, { desc = '将条目恢复到左侧状态' } },
            { 'n', 'L', actions.open_commit_log, { desc = '打开提交日志面板' } },
            { 'n', 'zo', actions.open_fold, { desc = '展开折叠' } },
            { 'n', 'h', actions.close_fold, { desc = '收起折叠' } },
            { 'n', 'zc', actions.close_fold, { desc = '收起折叠' } },
            { 'n', 'za', actions.toggle_fold, { desc = '切换折叠' } },
            { 'n', 'zR', actions.open_all_folds, { desc = '展开所有折叠' } },
            { 'n', 'zM', actions.close_all_folds, { desc = '收起所有折叠' } },
            { 'n', '<c-b>', actions.scroll_view(-0.25), { desc = '向上滚动视图' } },
            { 'n', '<c-f>', actions.scroll_view(0.25), { desc = '向下滚动视图' } },
            { 'n', 'xn', actions.select_next_entry, { desc = '打开下一个文件的差异' } },
            { 'n', 'xp', actions.select_prev_entry, { desc = '打开上一个文件的差异' } },
            { 'n', '[F', actions.select_first_entry, { desc = '打开第一个文件的差异' } },
            { 'n', ']F', actions.select_last_entry, { desc = '打开最后一个文件的差异' } },
            { 'n', 'gf', actions.goto_file_edit, { desc = '在上一个标签页中打开文件' } },
            { 'n', '<C-w><C-f>', actions.goto_file_split, { desc = '在新分屏中打开文件' } },
            { 'n', '<C-w>gf', actions.goto_file_tab, { desc = '在新标签页中打开文件' } },
            { 'n', 'i', actions.listing_style, { desc = "在'列表'和'树'视图之间切换" } },
            { 'n', 'f', actions.toggle_flatten_dirs, { desc = '在树形列表样式中展平空子目录' } },
            { 'n', 'R', actions.refresh_files, { desc = '更新文件列表中的统计信息和条目' } },
            { 'n', 'xe', actions.focus_files, { desc = '将焦点移到文件面板' } },
            { 'n', 'xb', actions.toggle_files, { desc = '切换文件面板' } },
            { 'n', 'g<C-x>', actions.cycle_layout, { desc = '循环浏览可用布局' } },
            { 'n', '[x', actions.prev_conflict, { desc = '跳转到上一个冲突' } },
            { 'n', ']x', actions.next_conflict, { desc = '跳转到下一个冲突' } },
            { 'n', '?', actions.help('file_panel'), { desc = '打开帮助面板' } },
            { 'n', 'xO', actions.conflict_choose_all('ours'), { desc = '为整个文件选择冲突的OURS版本' } },
            { 'n', 'xT', actions.conflict_choose_all('theirs'), { desc = '为整个文件选择冲突的THEIRS版本' } },
            { 'n', 'xB', actions.conflict_choose_all('base'), { desc = '为整个文件选择冲突的BASE版本' } },
            { 'n', 'xA', actions.conflict_choose_all('all'), { desc = '为整个文件选择冲突的所有版本' } },
            { 'n', 'dX', actions.conflict_choose_all('none'), { desc = '删除整个文件的冲突区域' } },
          },
          file_history_panel = {
            { 'n', 'g!', actions.options, { desc = '打开选项面板' } },
            { 'n', '<C-A-d>', actions.open_in_diffview, { desc = '在差异视图中打开光标下的条目' } },
            { 'n', 'y', actions.copy_hash, { desc = '复制光标下条目的提交哈希' } },
            { 'n', 'L', actions.open_commit_log, { desc = '显示提交详情' } },
            { 'n', 'X', actions.restore_entry, { desc = '将文件恢复到所选条目的状态' } },
            { 'n', 'zo', actions.open_fold, { desc = '展开折叠' } },
            { 'n', 'zc', actions.close_fold, { desc = '收起折叠' } },
            { 'n', 'h', actions.close_fold, { desc = '收起折叠' } },
            { 'n', 'za', actions.toggle_fold, { desc = '切换折叠' } },
            { 'n', 'zR', actions.open_all_folds, { desc = '展开所有折叠' } },
            { 'n', 'zM', actions.close_all_folds, { desc = '收起所有折叠' } },
            { 'n', 'j', actions.next_entry, { desc = '将光标移到下一个文件条目' } },
            { 'n', '<down>', actions.next_entry, { desc = '将光标移到下一个文件条目' } },
            { 'n', 'k', actions.prev_entry, { desc = '将光标移到上一个文件条目' } },
            { 'n', '<up>', actions.prev_entry, { desc = '将光标移到上一个文件条目' } },
            { 'n', '<cr>', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', 'o', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', 'l', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', '<2-LeftMouse>', actions.select_entry, { desc = '打开所选条目的差异' } },
            { 'n', '<c-b>', actions.scroll_view(-0.25), { desc = '向上滚动视图' } },
            { 'n', '<c-f>', actions.scroll_view(0.25), { desc = '向下滚动视图' } },
            { 'n', '<tab>', actions.select_next_entry, { desc = '打开下一个文件的差异' } },
            { 'n', '<s-tab>', actions.select_prev_entry, { desc = '打开上一个文件的差异' } },
            { 'n', '[F', actions.select_first_entry, { desc = '打开第一个文件的差异' } },
            { 'n', ']F', actions.select_last_entry, { desc = '打开最后一个文件的差异' } },
            { 'n', 'gf', actions.goto_file_edit, { desc = '在上一个标签页中打开文件' } },
            { 'n', '<C-w><C-f>', actions.goto_file_split, { desc = '在新分屏中打开文件' } },
            { 'n', '<C-w>gf', actions.goto_file_tab, { desc = '在新标签页中打开文件' } },
            { 'n', 'xe', actions.focus_files, { desc = '将焦点移到文件面板' } },
            { 'n', 'xb', actions.toggle_files, { desc = '切换文件面板' } },
            { 'n', 'g<C-x>', actions.cycle_layout, { desc = '循环浏览可用布局' } },
            { 'n', '?', actions.help('file_history_panel'), { desc = '打开帮助面板' } },
          },
          option_panel = {
            { 'n', '<tab>', actions.select_entry, { desc = '更改当前选项' } },
            { 'n', 'q', actions.close, { desc = '关闭面板' } },
            { 'n', '?', actions.help('option_panel'), { desc = '打开帮助面板' } },
          },
          help_panel = {
            { 'n', 'q', actions.close, { desc = '关闭帮助面板' } },
            { 'n', '<esc>', actions.close, { desc = '关闭帮助面板' } },
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
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
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
      -- vim.g.signify_vcs_cmds_diffmode = {
      --   svn = 'wsl svn cat %f',
      -- }
    end,
  },
}

return M
