local M = {
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
    submodules = false,
  },
  {
    'echasnovski/mini.ai',
    version = false,
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          f = false,
          t = false,
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
          -- <div #name name="name" :text="greetingMessage" v-slot="slotProps" #[dynamicSlotName] v-slot:[dynamicSlotName] ></div>
          x = {
            {
              '%s([@:]?[%w:-]+=").-"',
              "%s([@:]?[%w-]+=').-'",
              '%s([%w-]+={).-}',
              '%s([#]?[%w-]+)%[.-%]',
            },
            '^().*()$',
          },
        },
      }
    end,
  },
}

return M
