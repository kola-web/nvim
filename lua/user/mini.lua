local M = {
  -- align
  {
    'echasnovski/mini.align',
    version = false,
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
    version = false,
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

  -- 高亮光标下单词
  {
    'echasnovski/mini.cursorword',
    version = false,
    opts = {
      deily = 100,
    },
  },

  -- 替换、排序
  {
    'echasnovski/mini.operators',
    version = false,
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
        prefix = nil,
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
    version = false,
    opts = {
      mappings = {
        toggle = '<leader>j',
      },
    },
  },
}

return M
