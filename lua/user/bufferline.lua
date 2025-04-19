local M = {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '(', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ')', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('utils.icons').diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        get_element_icon = function(opts)
          return require('utils.icons').ft[opts.filetype]
        end,
      },
    },
    config = function(_, opts)
      local bufferline = require('bufferline')
      bufferline.setup(opts)

      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- {
  --   'echasnovski/mini.tabline',
  --   version = '*',
  --   opts = {
  --     format = function(buf_id, label)
  --       local suffix = ''
  --       if vim.bo[buf_id].modified then
  --         suffix = '● '
  --       elseif vim.bo[buf_id].readonly then
  --         suffix = ' '
  --       end
  --       return MiniTabline.default_format(buf_id, label) .. suffix
  --     end,
  --   },
  -- },
}

return M
