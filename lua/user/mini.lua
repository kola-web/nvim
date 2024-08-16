local M = {
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
        prefix = 'sx',
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

  -- auto pair
  {
    'echasnovski/mini.pairs',
    version = false,
    opts = {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
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
