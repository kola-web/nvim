local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = true,
        highlight = {
          backdrop = false,
        },
        char_actions = function(motion)
          return {
            [';'] = 'next', -- set to `right` to always go right
            [','] = 'prev', -- set to `left` to always go left
            -- jump2d style: same case goes next, opposite case goes prev
            [motion] = 'next',
            [motion:match('%l') and motion:upper() or motion:lower()] = 'prev',
          }
        end,
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
        '<leader><leader>w',
        mode = 'n',
        function()
          require('utils.init').flashWord()
        end,
        desc = 'Flash flashWord',
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
        '<leader><leader>a',
        mode = 'n',
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash treesitter',
      },
      {
        '<c-s>',
        mode = 'n',
        function()
          require('flash').toggle()
        end,
        desc = 'Flash toggle',
      },
    }
  end,
}

return M
