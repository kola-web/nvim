local M = {
  {
    'github/copilot.vim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ['grug-far'] = false,
        ['grug-far-history'] = false,
        ['grug-far-help'] = false,
      }
    end,
    keys = {
      { '<C-l>', 'copilot#Accept("")', desc = 'Copilot panel', mode = { 'i' }, expr = true, replace_keycodes = false, silent = true },
      { '<C-S-l>', '<Plug>(copilot-suggest)', desc = 'Copilot suggest', mode = { 'i' }, noremap = true, silent = true },
      { '<C-j>', '<Plug>(copilot-next)', desc = 'Copilot next', mode = { 'i' }, noremap = true, silent = true },
      { '<C-k>', '<Plug>(copilot-previous)', desc = 'Copilot prev', mode = { 'i' }, noremap = true, silent = true },
      { '<C-i>', '<Plug>(copilot-dismiss)', desc = 'Copilot dismiss', mode = { 'i' }, noremap = true, silent = true },
      { '<leader>ao', '<cmd>Copilot panel<cr>', desc = 'Copilot panel' },
      { '<leader>ae', '<cmd>Copilot enable<cr>', desc = 'Copilot enable' },
      { '<leader>ad', '<cmd>Copilot disable<cr>', desc = 'Copilot disable' },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-l>', -- handled by nvim-cmp / blink.cmp
          next = '<C-j>',
          prev = '<C-k>',
          dismiss = '<C-]>',
        },
      },
      panel = { enabled = false },
      -- LOCALAPPDATA
      copilot_node_command = require('utils.init').find_latest_volta_node(), -- Use the system node command
      filetypes = {
        ['*'] = true,
        ['grug-far'] = false,
        ['grug-far-history'] = false,
        ['grug-far-help'] = false,
      },
    },
  },
  -- {
  --   'Exafunction/windsurf.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     require('codeium').setup({})
  --   end,
  -- },
  {
    'olimorris/codecompanion.nvim',
    lazy = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      adapters = {},
      strategies = {},
      opts = {
        log_level = 'DEBUG',
        language = 'Chinese',
      },
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanionActions', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanionChat Toggle', mode = { 'n', 'v' }, noremap = true, silent = true },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
    },
  },
}

return M
