local M = {
  {
    'github/copilot.vim',
    enabled = true,
    event = 'VeryLazy',
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ['grug-far'] = false,
        ['grug-far-history'] = false,
        ['grug-far-help'] = false,
        ['codecompanion'] = false,
      }
    end,
    keys = {
      { '<C-l>', 'copilot#Accept("")', desc = 'Copilot panel', mode = { 'i' }, expr = true, replace_keycodes = false, silent = true },
      { '<C-j>', '<Plug>(copilot-next)', desc = 'Copilot next', mode = { 'i' }, noremap = true, silent = true },
      { '<C-k>', '<Plug>(copilot-previous)', desc = 'Copilot prev', mode = { 'i' }, noremap = true, silent = true },
      { '<C-]>', '<Plug>(copilot-dismiss)', desc = 'Copilot dismiss', mode = { 'i' }, noremap = true, silent = true },
    },
  },
  {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    config = function()
      local neocodeium = require('neocodeium')
      neocodeium.setup({
        enabled = false,
        debounce = true,
        silent = true,
        show_label = false,
      })
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      opts = {
        log_level = 'DEBUG',
        language = 'Chinese',
      },
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      adapters = {
        http = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'http://localhost:11434',
              },
              adapter = 'ollama',
              schema = {
                model = {
                  default = 'gemma3:4b',
                },
              },
            })
          end,
        },
      },
      strategies = {
        --NOTE: Change the adapter as required
        chat = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
        agent = { adapter = 'ollama' },
      },
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanionActions', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanionChat Toggle', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>al', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
    },
  },
}

return M
