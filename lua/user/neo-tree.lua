local M = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        commands = {
          copy_file_name = function(state)
            local node = state.tree:get_node()
            vim.fn.setreg('*', node.name, 'c')
          end,
          copy_file_path = function(state)
            local node = state.tree:get_node()
            local full_path = node.path
            local relative_path = full_path:sub(#state.path + 2)
            vim.fn.setreg('*', relative_path, 'c')
          end,
          diff_files = function(state)
            local node = state.tree:get_node()
            local log = require('neo-tree.log')
            state.clipboard = state.clipboard or {}
            if diff_Node and diff_Node ~= tostring(node.id) then
              local current_Diff = node.id
              require('neo-tree.utils').open_file(state, diff_Node, open)
              vim.cmd('vert diffs ' .. current_Diff)
              log.info('Diffing ' .. diff_Name .. ' against ' .. node.name)
              diff_Node = nil
              current_Diff = nil
              state.clipboard = {}
              require('neo-tree.ui.renderer').redraw(state)
            else
              local existing = state.clipboard[node.id]
              if existing and existing.action == 'diff' then
                state.clipboard[node.id] = nil
                diff_Node = nil
                require('neo-tree.ui.renderer').redraw(state)
              else
                state.clipboard[node.id] = { action = 'diff', node = node }
                diff_Name = state.clipboard[node.id].node.name
                diff_Node = tostring(state.clipboard[node.id].node.id)
                log.info('Diff source file ' .. diff_Name)
                require('neo-tree.ui.renderer').redraw(state)
              end
            end
          end,
          open_file_system = function(state)
            require('utils.init').open(state.tree:get_node().path, { system = true })
          end,
          mini_component = function(state)
            local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
            local node = state.tree:get_node()
            local currentPath = node._parent_id
            vim.fn.system({
              'cp',
              '-R',
              '/Users/lijialin/.config/nvim/template/' .. 'wxmlComponent',
              currentPath,
            })
            fs_actions.rename_node(currentPath .. '/wxmlComponent', function(_, path)
              vim.cmd('edit ' .. path .. '/index.wxml')
            end)
          end,
          mini_page = function(state)
            local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
            local node = state.tree:get_node()
            local currentPath = node._parent_id
            vim.fn.system({
              'cp',
              '-R',
              '/Users/lijialin/.config/nvim/template/' .. 'wxmlPage',
              currentPath,
            })
            fs_actions.rename_node(currentPath .. '/wxmlPage', function(_, path)
              vim.cmd('edit ' .. path .. '/index.wxml')
            end)
          end,
        },
        window = {
          mappings = {
            ['<space>'] = 'none',
            ['<C-t>c'] = 'mini_component',
            ['<C-t>p'] = 'mini_page',
            ['Y'] = 'copy_file_name',
            ['<C-y>'] = 'copy_file_path',
            ['D'] = 'diff_files',
            ['O'] = 'open_file_system',
          },
        },
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        config = function()
          require('window-picker').setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          })
        end,
      },
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', 'Explorer', mode = { 'n' } },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['-'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['<'] = 'actions.parent',
        ['>'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' } },
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', 'Open parent directory', mode = { 'n' } },
    },
  },
}

return M
