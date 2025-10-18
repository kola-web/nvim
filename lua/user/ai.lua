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
    'folke/sidekick.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = function()
      return {
        cli = {
          ---@type table<string, sidekick.cli.Config|{}>
          tools = {
            qwen = {
              cmd = { 'qwen' },
              env = {
                -- $env:HTTP_PROXY = '';$env:HTTPS_PROXY = '';
                HTTP_PROXY = '',
                HTTPS_PROXY = '',
              },
            },
          },
        },
      }
    end,
    keys = {
      {
        '<C-l>',
        function()
          if require('sidekick').nes_jump_or_apply() then
            return
          end

          return '<C-l>'
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
        mode = { 'i' },
      },
      {
        '<C-A-i>',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        desc = 'Select CLI',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send({ msg = '{this}' })
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send({ msg = '{file}' })
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send({ msg = '{selection}' })
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
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
    end,
    keys = {
      {
        '<C-l>',
        function()
          require('neocodeium').accept()
        end,
        desc = 'Neocodeium accept',
        mode = { 'i' },
        silent = true,
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    enabled = false,
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
      { '<leader>al', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
    },
  },
}

return M
