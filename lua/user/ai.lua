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
    enabled = false,
    lazy = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'franco-ruggeri/codecompanion-spinner.nvim',
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
    end,

    opts = {
      opts = {
        log_level = 'DEBUG',
        language = 'Chinese',
      },
      display = {
        action_palette = {
          provider = 'snacks',
        },
        diff = {
          enabled = true,
        },
        inline = {
          layout = 'buffer', -- vertical|horizontal|buffer
        },
      },
      strategies = {
        chat = { adapter = 'aliyun_qwen' },
        inline = { adapter = 'aliyun_qwen' },
        agent = { adapter = 'aliyun_qwen' },
      },
      adapters = {
        http = {
          aliyun_qwen = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = 'aliyun_qwen',
              env = {
                url = 'https://dashscope.aliyuncs.com',
                api_key = function()
                  return os.getenv('QWEN_API_KEY')
                end,
                chat_url = '/compatible-mode/v1/chat/completions',
              },
              schema = {
                model = {
                  default = 'qwen3-coder-plus',
                },
              },
            })
          end,
        },
      },
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.getcwd() .. '/.prompts', -- Can be relative
            vim.fn.stdpath('config') .. '/prompts',
          },
        },
      },
    },
    keys = {
      {
        '<leader>aa',
        function()
          require('codecompanion').actions({})
          vim.cmd.stopinsert()
        end,
        desc = 'CodeCompanionActions',
        mode = { 'n', 'v' },
        noremap = true,
        silent = true,
      },
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanionChat Toggle', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ar', '<cmd>CodeCompanionChat refresh<cr>', desc = 'CodeCompanionChat refresh', mode = { 'n' }, noremap = true, silent = true },
      { '<leader>al', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
    },
  },
  {
    'folke/sidekick.nvim',
    enabled = true,
    opts = {
      -- 在这里添加任何选项
      cli = {
        win = {
          split = {
            width = 100,
          },
        },
      },
      nes = {
        enabled = false,
      },
    },
    keys = {
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle({ name = 'qwen', focus = true })
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
          -- vim.cmd.stopinsert()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
    },
  },
  {
    'yetone/avante.nvim',
    enabled = false,
    build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false,
    opts = function()
      ---@module 'avante'
      ---@type avante.Config
      return {
        provider = 'qianwen',
        providers = {
          deepseek = {
            __inherited_from = 'openai',
            api_key_name = 'DEEPSEEK_API_KEY',
            endpoint = 'https://api.deepseek.com/v1',
            model = 'deepseek-coder',
          },
          qianwen = {
            __inherited_from = 'openai',
            api_key_name = 'QWEN_API_KEY',
            endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1',
            model = 'qwen3-coder-plus',
          },
        },
      }
    end,
  },
}

return M
