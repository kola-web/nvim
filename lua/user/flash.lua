local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    jump = {
      nohlsearch = true,
    },
    modes = {
      search = {
        -- enabled = false,
      },
      char = {
        -- enabled = false,
        highlight = { backdrop = false },
      },
    },
  },
  keys = {
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
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
      '<leader><leader>w',
      mode = 'n',
      function()
        require('util.init').flashWord()
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
  },
}

return M
