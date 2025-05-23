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
    opts = {
      windows = {
        preview = false,
        width_focus = 30,
        width_preview = 30,
      },
      mappings = {
        go_in = 'L',
        go_in_plus = 'l',
        go_out = 'H',
        go_out_plus = 'h',
        synchronize = '<cr>',
      },
      content = {
        sort = function(entries)
          local function compare_alphanumerically(e1, e2)
            -- Put directories first.
            if e1.is_dir and not e2.is_dir then
              return true
            end
            if not e1.is_dir and e2.is_dir then
              return false
            end
            -- Order numerically based on digits if the text before them is equal.
            if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
              return e1.digits < e2.digits
            end
            -- Otherwise order alphabetically ignoring case.
            return e1.lower_name < e2.lower_name
          end

          local sorted = vim.tbl_map(function(entry)
            local pre_digits, digits = entry.name:match('^(%D*)(%d+)')
            if digits ~= nil then
              digits = tonumber(digits)
            end

            return {
              fs_type = entry.fs_type,
              name = entry.name,
              path = entry.path,
              lower_name = entry.name:lower(),
              is_dir = entry.fs_type == 'directory',
              pre_digits = pre_digits,
              digits = digits,
            }
          end, entries)
          table.sort(sorted, compare_alphanumerically)
          -- Keep only the necessary fields.
          return vim.tbl_map(function(x)
            return { name = x.name, fs_type = x.fs_type, path = x.path }
          end, sorted)
        end,
      },
      options = {
        permanent_delete = false,
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)
      -- 转义文件名，防止 Lua 模式匹配问题

      local copy_file_path = require('utils.init').copy_file_path
      local add_to_gitignore = require('utils.init').add_to_gitignore
      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh({ content = { filter = new_filter } })
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require('mini.files').get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd('belowright ' .. direction .. ' split')
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require('mini.files').set_target_window(new_target_window)
            require('mini.files').go_in({ close_on_file = close_on_file })
          end
        end

        local desc = 'Open in ' .. direction .. ' split'
        if close_on_file then
          desc = desc .. ' and close'
        end
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      local files_grug_far_replace = function(path)
        -- works only if cursor is on the valid file system entry
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local prefills = { paths = vim.fs.dirname(cur_entry_path) }

        local grug_far = require('grug-far')

        -- instance check
        if not grug_far.has_instance('explorer') then
          grug_far.open({
            instanceName = 'explorer',
            prefills = prefills,
            staticTitle = 'Find and Replace from Explorer',
          })
        else
          grug_far.get_instance('explorer'):open()
          -- updating the prefills without crealing the search and other fields
          grug_far.get_instance('explorer'):update_input_values(prefills, false)
        end
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
          vim.keymap.set('n', 'gc', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })

          map_split(buf_id, '<C-w>s', 'horizontal', false)
          map_split(buf_id, '<C-w>v', 'vertical', false)
          map_split(buf_id, '<C-w>S', 'horizontal', true)
          map_split(buf_id, '<C-w>V', 'vertical', true)

          vim.keymap.set('n', 'wc', vim.g.mini_file_mini_component, { buffer = buf_id, desc = 'mini_component' })
          vim.keymap.set('n', 'wp', vim.g.mini_file_mini_page, { buffer = buf_id, desc = 'mini_page' })
          vim.keymap.set('n', '<C-y>', copy_file_path, { buffer = buf_id, desc = 'copy_file_path' })
          vim.keymap.set('n', 'gi', add_to_gitignore, { buffer = buf_id, desc = 'Add to .gitignore' })
          -- insert mode  move corsor right
          vim.keymap.set('i', '<C-f>', '<C-o>l', { buffer = buf_id, desc = 'move cursor right' })
          vim.keymap.set('i', '<C-b>', '<C-o>h', { buffer = buf_id, desc = 'move cursor left' })

          vim.keymap.set('n', 'gs', files_grug_far_replace, { buffer = buf_id, desc = 'Search in directory' })
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesActionRename',
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
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
