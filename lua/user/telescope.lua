local M = {
  'nvim-telescope/telescope.nvim',
  event = 'Bufenter',
  cmd = { 'Telescope' },
  dependencies = {
    {
      'nvim-telescope/telescope-file-browser.nvim',
    },
    {
      'folke/noice.nvim',
    },
  },
}

M.config = function()
  local trouble = require('trouble.providers.telescope')
  local status_ok, telescope = pcall(require, 'telescope')
  if not status_ok then
    return
  end

  local actions = require('telescope.actions')

  local previewers = require('telescope.previewers')

  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then
        return
      end
      if stat.size > 100000 then
        return
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  local function flash(prompt_bufnr)
    require('flash').jump({
      pattern = '^',
      label = { after = { 0, 0 } },
      search = {
        mode = 'search',
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
          end,
        },
      },
      action = function(match)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    })
  end

  local opts = {
    defaults = {
      -- prompt_prefix = ' ',
      prompt_prefix = '',
      selection_caret = ' ',
      buffer_previewer_maker = new_maker,
      file_ignore_patterns = {
        '.git/',
        '.svn/',
        'node_modules',
        'miniprogram_npm',
        '.yarn/',
        'dist',
      },
      mappings = {
        i = {
          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,
          ['<C-j>'] = actions.cycle_history_next,
          ['<C-k>'] = actions.cycle_history_prev,
          ['<CR>'] = actions.select_default,
          ['<c-s>'] = flash,
          ['<c-t>'] = trouble.open_with_trouble,
        },
        n = {
          ['?'] = actions.which_key,
          ['<c-s>'] = flash,
          ['<c-t>'] = trouble.open_with_trouble,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      },
      buffers = {
        initial_mode = 'normal',
      },
      diagnostics = {
        initial_mode = 'normal',
      },
      lsp_code_actions = {
        initial_mode = 'normal',
      },
    },
    extensions = {
      file_browser = {
        initial_mode = 'normal',
        theme = 'dropdown',
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = false,
        mappings = {
          ['i'] = {
            -- your custom insert mode mappings
            ['<C-w>'] = function()
              vim.cmd('normal vbd')
            end,
          },
          ['n'] = {
            -- your custom normal mode mappings
            ['/'] = function()
              vim.cmd('startinsert')
            end,
          },
        },
      },
      package_info = {
        initial_mode = 'normal',
      },
    },
  }

  telescope.setup(opts)
  telescope.load_extension('file_browser')
  telescope.load_extension('noice')
  telescope.load_extension('package_info')
end

return M
