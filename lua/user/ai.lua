local M = {
  {
    enabled = false,
    'github/copilot.vim',
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
      { '<C-]>', '<Plug>(copilot-dismiss)', desc = 'Copilot dismiss', mode = { 'i' }, noremap = true, silent = true },
      { '<leader>ao', '<cmd>Copilot panel<cr>', desc = 'Copilot panel' },
      { '<leader>ae', '<cmd>Copilot enable<cr>', desc = 'Copilot enable' },
      { '<leader>ad', '<cmd>Copilot disable<cr>', desc = 'Copilot disable' },
    },
  },
  {
    'monkoose/neocodeium',
    enabled = true,
    event = 'VeryLazy',
    config = function()
      local neocodeium = require('neocodeium')
      neocodeium.setup({
        debounce = true,
        silent = true,
        show_label = false,
      })
      vim.keymap.set('i', '<C-l>', neocodeium.accept)
      vim.keymap.set('i', '<C-j>', function()
        neocodeium.cycle_or_complete()
      end)
      vim.keymap.set('i', '<C-k>', function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set('i', '<C-]>', function()
        neocodeium.clear()
      end)
    end,
  },
  {
    'milanglacier/minuet-ai.nvim',
    enabled = false,
    config = function()
      require('minuet').setup({
        virtualtext = {
          auto_trigger_ft = { '*' },
          keymap = {
            -- accept whole completion
            accept = '<C-l>',
            -- accept one line
            accept_line = '<C-S-l>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<nil>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<C-k>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<C-j>',
            dismiss = '<C-]>',
          },
        },

        provider = 'openai_compatible',
        provider_options = {
          openai_compatible = {
            end_point = 'https://api.deepseek.com/chat/completions',
            api_key = function()
              return os.getenv('DEEPSEEK_KEY')
            end,
            name = 'deepseek',
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
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
