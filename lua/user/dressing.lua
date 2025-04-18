local M = {
  'stevearc/dressing.nvim',
  lazy = true,
  enabled = false,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('lazy').load({ plugins = { 'dressing.nvim' } })
      return vim.ui.select(...)
    end
  end,
  opts = {
    select = {
      get_config = function(opts)
        if opts.kind == 'codeaction' then
          return {
            backend = 'builtin',
          }
        end
      end,
    },
  },
}

return M
