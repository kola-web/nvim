local M = {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      {
        'nvim-tree/nvim-web-devicons',
      },
    },
    keys = {
      { '<S-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      { '<tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '(', '<cmd>BufferLineMovePrev<cr>', desc = 'move prev' },
      { ')', '<cmd>BufferLineMoveNext<cr>', desc = 'move move' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'buffer Close All But Current' },
      { '<leader>c', '<cmd>bdelete<cr>', desc = 'close current buffer' },
    },
    opts = {
      options = {
        -- mode = 'tabs', -- set to "tabs" to only show tabpages instead
        themable = true,
        close_command = function(n)
          require('utils.ui').bufremove(n)
        end, -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = function(n)
          require('utils.ui').bufremove(n)
        end, -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
        diagnostics = 'nvim_lsp',
        show_tab_indicators = true,
        separator_style = 'thick',
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = true,
        show_duplicate_prefix = false,
        indicator = {
          style = 'underline',
        },
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'EXPLORER',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'NvimTree',
            text = 'EXPLORER',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}

return M
