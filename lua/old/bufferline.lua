local M = {
  'akinsho/bufferline.nvim',
  event = { 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  dependencies = {
    {
      'echasnovski/mini.bufremove',
    },
    {
      'nvim-tree/nvim-web-devicons',
    },
  },
  keys = {
    { '<S-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '(', '<cmd>BufferLineMovePrev<cr>', desc = 'move prev' },
    { ')', '<cmd>BufferLineMoveNext<cr>', desc = 'move move' },
  },
  opts = {
    options = {
      -- mode = 'tabs', -- set to "tabs" to only show tabpages instead
      themable = true,
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = 'nvim_lsp',
      show_tab_indicators = true,
      persist_buffer_sort = false,
      enforce_regular_tabs = true,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      indicator = {
        style = 'underline',
      },
      numbers = function(opts)
        return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
    },
  },
}
function M.config(_, opts)
  require('bufferline').setup(opts)
  -- Fix bufferline when restoring a session
  vim.api.nvim_create_autocmd('BufAdd', {
    callback = function()
      vim.schedule(function()
        pcall(nvim_bufferline)
      end)
    end,
  })
end

return M
