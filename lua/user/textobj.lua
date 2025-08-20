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
    'chrisgrieser/nvim-various-textobjs',
    lazy = true,
    opts = {
      keymaps = {
        useDefaults = false,
      },
    },
    keys = {
      { mode = { 'x', 'o' }, 'ae', '<cmd>lua require("various-textobjs").entireBuffer()<CR>' },

      { mode = { 'x', 'o' }, 'ic', '<cmd>lua require("various-textobjs").color("inner")<CR>' },
      { mode = { 'x', 'o' }, 'ac', '<cmd>lua require("various-textobjs").color("outer")<CR>' },

      { mode = { 'x', 'o' }, 'ii', '<cmd>lua require("various-textobjs").indentation("inner","inner")<CR>' },
      { mode = { 'x', 'o' }, 'ai', '<cmd>lua require("various-textobjs").indentation("outer","outer")<CR>' },

      -- { mode = { 'x', 'o' }, 'ix', '<cmd>lua require("various-textobjs").htmlAttribute("outer")<CR>' },
    },
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
