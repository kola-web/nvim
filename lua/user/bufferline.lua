local M = {
  -- {
  --   'romgrk/barbar.nvim',
  --   event = { 'VimEnter', 'InsertEnter', 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  --   dependencies = {
  --     'lewis6991/gitsigns.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --   end,
  --   opts = {
  --     animation = false,
  --     icons = {
  --       diagnostics = {
  --         [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require('util.icons').diagnostics.Error },
  --         [vim.diagnostic.severity.WARN] = { enabled = true, icon = require('util.icons').diagnostics.Warn },
  --         [vim.diagnostic.severity.INFO] = { enabled = false, icon = require('util.icons').diagnostics.Info },
  --         [vim.diagnostic.severity.HINT] = { enabled = true, icon = require('util.icons').diagnostics.Hint },
  --       },
  --     },
  --     sidebar_filetypes = {
  --       undotree = {
  --         text = 'undotree',
  --         align = 'center',
  --       },
  --       ['neo-tree'] = {
  --         text = 'neo-tree',
  --         align = 'center',
  --       },
  --     },
  --     insert_at_end = false,
  --   },
  --   keys = {
  --     { '<S-tab>', '<cmd>BufferPrevious<cr>', desc = 'Prev buffer' },
  --     { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
  --     { '(', '<cmd>BufferMovePrevious<cr>', desc = 'move prev' },
  --     { ')', '<cmd>BufferMoveNext<cr>', desc = 'move move' },
  --     { '<leader>br', '<cmd>BufferRestore<cr>', desc = 'Restore buffer' },
  --     -- { '<leader>bo', '<cmd>BufferCloseAllButCurrent<cr>', desc = 'buffer Close All But Current' },
  --     -- { '<leader>c', '<cmd>BufferClose<cr>', desc = 'close current buffer' },
  --   },
  -- },
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
      { '(', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ')', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('utils.icons').diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warning .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return require('utils.icons').ft[opts.filetype]
        end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
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
}

return M
