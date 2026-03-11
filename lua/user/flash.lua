local M = {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          highlight = { backdrop = false },
        },
      },
      highlight = { backdrop = false },
      label = {
        uppercase = false,
        current = true,
        rainbow = {
          enabled = true,
          -- 颜色深浅度（1-9）
          shade = 1,
        },
      },
    },
    keys = {
      {
        '<cr>',
        mode = { 'n', 'x', 'o' },
        function()
          local buftype = vim.bo.buftype
          if buftype == 'quickfix' then
            vim.fn['setqflist']({}, 'a')
            vim.cmd([[execute "normal! \<CR>"]])
          else
            require('flash').jump()
          end
        end,
        desc = 'Flash',
      },
      {
        '<S-CR>',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
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
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}

return M
