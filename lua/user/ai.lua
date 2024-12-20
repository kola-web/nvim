local M = {
  -- {
  --   'github/copilot.vim',
  --   event = 'InsertEnter',
  --   config = function()
  --     vim.g.copilot_enabled = true
  --     vim.g.copilot_no_tab_map = true
  --   end,
  --   keys = {
  --     { '<C-l>', 'copilot#Accept("")', desc = 'Copilot panel', mode = { 'i' }, expr = true, replace_keycodes = false, silent = true },
  --     { '<C-s>', '<Plug>(copilot-suggest)', desc = 'Copilot suggest', mode = { 'i' }, noremap = true, silent = true },
  --     { '<C-n>', '<Plug>(copilot-next)', desc = 'Copilot next', mode = { 'i' }, noremap = true, silent = true },
  --     { '<C-p>', '<Plug>(copilot-previous)', desc = 'Copilot prev', mode = { 'i' }, noremap = true, silent = true },
  --     { '<leader>ao', '<cmd>Copilot panel<cr>', desc = 'Copilot panel' },
  --     { '<leader>ae', '<cmd>Copilot enable<cr>', desc = 'Copilot enable' },
  --     { '<leader>ad', '<cmd>Copilot disable<cr>', desc = 'Copilot disable' },
  --   },
  -- },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    keys = {
      {
        '<C-l>',
        function()
          require('copilot.suggestion').accept()
        end,
        desc = 'Copilot Accept',
        mode = { 'i' },
        expr = true,
        replace_keycodes = false,
        silent = true,
      },
      {
        '<C-j>',
        function()
          require('copilot.suggestion').next()
        end,
        desc = 'Copilot next',
        mode = { 'i' },
        noremap = true,
        silent = true,
      },
      {
        '<C-k>',
        function()
          require('copilot.suggestion').prev()
        end,
        desc = 'Copilot prev',
        mode = { 'i' },
        noremap = true,
        silent = true,
      },
      {
        '<C-x>',
        function()
          require('copilot.suggestion').dismiss()
        end,
        desc = 'Copilot dismiss',
        mode = { 'i' },
        noremap = true,
        silent = true,
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },

  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   cmd = {
  --     'CodeCompanion',
  --     'CodeCompanionChat',
  --     'CodeCompanionActions',
  --     'CodeCompanionCmd',
  --   },
  --   opts = {
  --     language = 'Chinese',
  --   },
  --   -- Expand 'cc' into 'CodeCompanion' in the command line
  --   init = function()
  --     vim.cmd([[cab cc CodeCompanion]])
  --   end,
  --   keys = {
  --     { '<leader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanionActions', mode = { 'n', 'v' }, noremap = true, silent = true },
  --     { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanionChat Toggle', mode = { 'n', 'v' }, noremap = true, silent = true },
  --     { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
  --   },
  -- },
}

return M
