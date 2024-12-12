local M = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    enabled = false,
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then
              require('neo-tree')
            end
          end
        end,
      })
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
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
          mini_component = vim.g.mini_component,
          mini_page = vim.g.mini_page,
        },
        window = {
          mappings = {
            ['<space>'] = 'none',
            ['wc'] = 'mini_component',
            ['wp'] = 'mini_page',
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
          ['w'] = 'none',
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        git_status = {
          symbols = {
            unstaged = '󰄱',
            staged = '󰱒',
          },
        },
      },
    },
    config = function(_, opts)
      -- LSP 集成文件重命名
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require('neo-tree').setup(opts)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>E',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = 'Explorer NeoTree (Root Dir)',
      },
    },
  },
  {
    'echasnovski/mini.files',
    version = '*',
    opts = function()
      return {
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
        options = {
          -- Whether to use for editing directories
          -- Disabled by default in LazyVim because neo-tree is used for that
          use_as_default_explorer = false,
        },
      }
    end,
    keys = {
      {
        '<leader>e',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
      {
        '<leader>E',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
    },
  },
}

return M
