local M = {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     {
  --       'zbirenbaum/copilot-cmp',
  --       config = true,
  --     },
  --   },
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = {
  --       enabled = true,
  --     },
  --     copilot_node_command = vim.fn.expand('$HOME') .. '/.n/n/versions/node/20.9.0/bin/node', -- Node.js version must be > 18.x
  --   },
  --   keys = {
  --     {
  --       '<leader>ao',
  --       '<cmd>Copilot panel<cr>',
  --       desc = 'Copilot panel',
  --     },
  --   },
  -- },

  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'canary',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  --   },
  --   opts = function()
  --     local select = require('CopilotChat.select')
  --     return {
  --       debug = false, -- Enable debugging
  --       show_help = true,
  --       -- See Configuration section for rest
  --       window = {
  --         layout = 'float',
  --         relative = 'cursor',
  --         width = 1,
  --         height = 0.4,
  --         row = 1,
  --       },
  --       prompts = { -- 提示配置
  --         Explain = { -- 解释提示
  --           prompt = '/COPILOT_EXPLAIN 为上面的代码写一个解释，作为文本段落。',
  --         },
  --         Tests = { -- 测试提示
  --           prompt = '/COPILOT_TESTS 为上面的代码写一组详细的单元测试函数。',
  --         },
  --         Fix = { -- 修复提示
  --           prompt = '/COPILOT_FIX 这段代码有问题。重写代码以显示修复后的效果。',
  --         },
  --         Optimize = { -- 优化提示
  --           prompt = '/COPILOT_REFACTOR 优化选定的代码以提高性能和可读性。',
  --         },
  --         Docs = { -- 文档提示
  --           prompt = '/COPILOT_REFACTOR 为选定的代码编写文档。回复应该是一个代码块，包含原始代码和作为注释添加的文档。使用最适合所用编程语言的文档风格（例如，JavaScript使用JSDoc，Python使用docstrings等）。',
  --         },
  --         FixDiagnostic = { -- 诊断修复提示
  --           prompt = '请协助处理以下文件中的诊断问题：',
  --         },
  --         Commit = { -- 提交提示
  --           prompt = '为更改编写符合commitizen约定的提交信息。确保标题最多有50个字符，信息在72个字符处换行。将整个信息用gitcommit语言的代码块包裹起来。',
  --         },
  --         CommitStaged = { -- 已暂存提交提示
  --           prompt = '为更改编写符合commitizen约定的提交信息。确保标题最多有50个字符，信息在72个字符处换行。将整个信息用gitcommit语言的代码块包裹起来。',
  --         },
  --       },
  --     }
  --   end,
  --   -- See Commands section for default commands if you want to lazy load on them
  --   keys = {
  --     {
  --       '<leader>aa',
  --       function()
  --         local input = vim.fn.input('Quick Chat: ')
  --         if input ~= '' then
  --           require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
  --         end
  --       end,
  --       desc = 'CopilotChat - Quick chat',
  --     },
  --     {
  --       '<leader>ah',
  --       function()
  --         local actions = require('CopilotChat.actions')
  --         require('CopilotChat.integrations.telescope').pick(actions.help_actions())
  --         vim.api.nvim_input('<Esc>')
  --       end,
  --       desc = 'CopilotChat - Help actions',
  --     },
  --     {
  --       '<leader>ap',
  --       function()
  --         local actions = require('CopilotChat.actions')
  --         require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
  --         vim.api.nvim_input('<Esc>')
  --       end,
  --       desc = 'CopilotChat - Prompt actions',
  --     },
  --     {
  --       '<leader>at',
  --       '<cmd>CopilotChatToggle<cr>',
  --       desc = 'CopilotChat Toggle',
  --     },
  --   },
  -- },

  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
    end,
    keys = {
      { '<C-l>', 'copilot#Accept("")', desc = 'Copilot panel', mode = { 'i' }, expr = true, replace_keycodes = false, silent = true },
      { '<C-s>', '<Plug>(copilot-suggest)', desc = 'Copilot suggest', mode = { 'i' }, noremap = true, silent = true },
      { '<C-n>', '<Plug>(copilot-next)', desc = 'Copilot next', mode = { 'i' }, noremap = true, silent = true },
      { '<C-p>', '<Plug>(copilot-previous)', desc = 'Copilot prev', mode = { 'i' }, noremap = true, silent = true },
      { '<leader>ao', '<cmd>Copilot panel<cr>', desc = 'Copilot panel' },
      { '<leader>ae', '<cmd>Copilot enable<cr>', desc = 'Copilot enable' },
      { '<leader>ad', '<cmd>Copilot disable<cr>', desc = 'Copilot disable' },
    },
  },
}

return M
