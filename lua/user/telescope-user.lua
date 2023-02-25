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
    path_display = nil,
    file_ignore_patterns = {
      '.git/',
      'target/',
      'docs/',
      'vendor/*',
      '%.lock',
      '__pycache__/*',
      '%.sqlite3',
      '%.ipynb',
      'node_modules/*',
      -- "%.jpg",
      -- "%.jpeg",
      -- "%.png",
      '%.svg',
      '%.otf',
      '%.ttf',
      '%.webp',
      '.dart_tool/',
      '.github/',
      '.gradle/',
      '.idea/',
      '.settings/',
      '.vscode/',
      '__pycache__/',
      'build/',
      'env/',
      'gradle/',
      'node_modules/',
      '%.pdb',
      '%.dll',
      '%.class',
      '%.exe',
      '%.cache',
      '%.ico',
      '%.pdf',
      '%.dylib',
      '%.jar',
      '%.docx',
      '%.met',
      'smalljre_*/*',
      '.vale/',
      '%.burp',
      '%.mp4',
      '%.mkv',
      '%.rar',
      '%.zip',
      '%.7z',
      '%.tar',
      '%.bz2',
      '%.epub',
      '%.flac',
      '%.tar.gz',
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
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'ui-select'
