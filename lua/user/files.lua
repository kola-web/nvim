local M = {
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
