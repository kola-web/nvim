local M = {
  {
    'github/copilot.vim',
    enabled = true,
    event = 'VeryLazy',
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ['markdown'] = false,
        ['wxml'] = false,
        ['html'] = false,
        ['scss'] = false,
        ['css'] = false,
        ['wxss'] = false,
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
    enabled = true,
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
        language = 'Chinese',
      },
      display = {
        action_palette = {
          provider = 'snacks',
        },
        diff = {
          enabled = true,
          word_highlights = {
            additions = true,
            deletions = true,
          },
        },
      },
      interactions = {
        chat = {
          adapter = 'txyun_plan',
          tools = {
            opts = {
              default_tools = {
                'agent',
              },
            },
          },
        },
        inline = { adapter = 'txyun_plan' },
        agent = { adapter = 'txyun_plan' },
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
          txyun_plan = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = 'txyun_plan',
              env = {
                url = 'https://api.lkeap.cloud.tencent.com/plan/v3',
                api_key = function()
                  return os.getenv('TX_API_KEY')
                end,
                chat_url = '/chat/completions',
              },
              schema = {
                model = {
                  default = 'kimi-k2.5',
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
      extensions = {
        spinner = {
          -- -- enabled = true, -- This is the default
          opts = {
            -- Your spinner configuration goes here
            -- style = 'cursor-relative',
            style = 'snacks',
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
      { '<leader>ai', '<cmd>CodeCompanion /custom_chat<cr>', desc = 'CodeCompanion CustomChat', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ar', '<cmd>CodeCompanionChat refresh<cr>', desc = 'CodeCompanionChat refresh', mode = { 'n' }, noremap = true, silent = true },
      { '<leader>al', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
    },
  },
  {
    'folke/sidekick.nvim',
    enabled = false,
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
}

return M
