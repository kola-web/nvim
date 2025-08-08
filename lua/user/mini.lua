local M = {
  -- align
  {
    'echasnovski/mini.align',
    version = '*',
    opts = {
      mappings = {
        start = 'ge',
        start_with_preview = 'gE',
      },
    },
  },

  -- surround
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {
      mappings = {
        add = 'ys', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        find = nil, -- Find surrounding (to the right)
        find_left = nil, -- Find surrounding (to the left)
        highlight = nil, -- Highlight surrounding
        replace = 'cs', -- Replace surrounding
        update_n_lines = nil, -- Update `n_lines`
        suffix_last = nil, -- Suffix to search with "prev" method
        suffix_next = nil, -- Suffix to search with "next" method
      },
    },
  },

  -- 替换、排序
  {
    'echasnovski/mini.operators',
    version = '*',
    opts = {
      evaluate = {
        prefix = nil,
        func = nil,
      },
      exchange = {
        prefix = 'S',
        reindent_linewise = true,
      },
      multiply = {
        prefix = 'gm',
        func = nil,
      },
      replace = {
        prefix = 's',
        reindent_linewise = true,
      },
      sort = {
        prefix = 'gs',
        func = nil,
      },
    },
  },

  {
    'echasnovski/mini.splitjoin',
    version = '*',
    opts = {
      mappings = {
        toggle = '<leader>j',
      },
    },
  },

  {
    'echasnovski/mini.icons',
    version = '*',
    opts = {
      file = {
        ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
        ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {},
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}

return M
