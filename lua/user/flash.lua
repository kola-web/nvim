local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    jump = {
      nohlsearch = true,
    },
    modes = {
      char = {
        -- enabled = false,
        highlight = { backdrop = false },
      },
    },
  },
  keys = function()
    return {
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<leader><leader>s',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Flash jump',
      },
      {
        '<leader><leader>v',
        mode = 'n',
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash treesitter',
      },
      {
        '<cr>',
        mode = 'n',
        function()
          require('utils.init').flashWord()
          -- require('utils.init').label2_jump(false, [[\<]])
        end,
        desc = 'Flash flashWord',
      },
      {
        '<leader><leader>/',
        mode = 'n',
        function()
          require('flash').toggle()
        end,
        desc = 'Flash toggle',
      },
      {
        '<leader><leader>l',
        mode = 'n',
        function()
          require('flash').jump({
            search = { mode = 'search', max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = '^',
          })
        end,
        desc = 'Flash line',
      },
    }
  end,
}

return M
