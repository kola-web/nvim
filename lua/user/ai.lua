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

vim.keymap.set('i', '<C-l>', 'copilot#Accept("")', { desc = 'Copilot panel', expr = true, replace_keycodes = false, silent = true })
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { desc = 'Copilot next', noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { desc = 'Copilot prev', noremap = true, silent = true })
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)', { desc = 'Copilot dismiss', noremap = true, silent = true })

local neocodeium_ok, neocodeium = pcall(require, 'neocodeium')
if neocodeium_ok then
  neocodeium.setup({
    enabled = false,
    debounce = true,
    silent = true,
    show_label = false,
  })
end

vim.cmd([[cab cc CodeCompanion]])

local codecompanion_ok, codecompanion = pcall(require, 'codecompanion')
if codecompanion_ok then
  codecompanion.setup({
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
          vim.fn.getcwd() .. '/.prompts',
          vim.fn.stdpath('config') .. '/prompts',
        },
      },
    },
    extensions = {
      spinner = {
        opts = {
          style = 'snacks',
        },
      },
    },
  })
end

vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  if codecompanion_ok then
    require('codecompanion').actions({})
    vim.cmd.stopinsert()
  end
end, { desc = 'CodeCompanionActions', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'CodeCompanionChat Toggle', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion /custom_chat<cr>', { desc = 'CodeCompanion CustomChat', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ar', '<cmd>CodeCompanionChat refresh<cr>', { desc = 'CodeCompanionChat refresh', noremap = true, silent = true })
vim.keymap.set('v', '<leader>al', '<cmd>CodeCompanionChat Add<cr>', { desc = 'CodeCompanionChat Add', noremap = true, silent = true })

local sidekick_ok, _ = pcall(require, 'sidekick')
if sidekick_ok then
  vim.keymap.set('n', '<leader>aa', function()
    require('sidekick.cli').toggle({ name = 'qwen', focus = true })
  end, { desc = 'Sidekick Toggle CLI' })
  vim.keymap.set({ 'n', 'x' }, '<leader>ap', function()
    require('sidekick.cli').prompt()
  end, { desc = 'Sidekick Select Prompt' })
end
