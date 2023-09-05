local M = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ['<C-t>c'] = function(state)
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
            ['<C-t>p'] = function(state)
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
                print(path)
                vim.cmd('edit ' .. path .. '/index.wxml')
              end)
            end,
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
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
  {
    'echasnovski/mini.bufremove',
    config = function()
      require('mini.bufremove').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
  },
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
    },
  },
}

return M
