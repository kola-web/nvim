local M = {
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
      },
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
          ['Y'] = 'copy_file_name',
          ['<C-y>'] = 'copy_file_path',
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
}

return M
