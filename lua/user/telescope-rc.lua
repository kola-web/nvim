local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local actions = require 'telescope.actions'

telescope.setup {
  defaults = {

    -- prompt_prefix = " ",
    prompt_prefix = '',
    selection_caret = ' ',
    dynamic_preview_title = true,
    file_ignore_patterns = {
      '.git',
      '.svn',
      'node_modules',
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
      },
      n = {
        ['q'] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      -- previewer = false,
      -- initial_mode = "normal",
    },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          -- your custom insert mode mappings
          ['<C-w>'] = function()
            vim.cmd 'normal vbd'
          end,
        },
        ['n'] = {
          -- your custom normal mode mappings
          ['/'] = function()
            vim.cmd 'startinsert'
          end,
        },
      },
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'ui-select'