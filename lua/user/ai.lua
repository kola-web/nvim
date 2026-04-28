vim.pack.add({
  'https://github.com/github/copilot.vim',
  'https://github.com/monkoose/neocodeium',
  'https://github.com/olimorris/codecompanion.nvim',
})

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

local codecompanion = require('codecompanion')
codecompanion.setup({
  opts = {
    language = 'Chinese',
  },
  display = {
    action_palette = {
      provider = 'snacks',
    },
    chat = {
      show_settings = true,
      render_headers = false,
    },
  },
  interactions = {
    chat = { adapter = 'txyun_kimi', keymaps = {
      close = { modes = { n = 'q', i = '<C-c>' } },
      stop = { modes = { n = '<C-c>' } },
    } },
    inline = { adapter = 'opencode' },
    agent = { adapter = 'txyun_minimax' },
  },
  adapters = {
    acp = {
      opencode = function()
        return require('codecompanion.adapters').extend('claude_code', {
          name = 'opencode',
          formatted_name = 'OpenCode',
          commands = {
            default = { 'opencode', 'acp' },
          },
        })
      end,
    },
    http = {
      txyun_kimi = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          name = 'txyun_kimi',
          env = {
            url = 'https://api.lkeap.cloud.tencent.com/plan/v3',
            api_key = function()
              return os.getenv('TX_API_KEY')
            end,
            chat_url = '/chat/completions',
            models_endpoint = '/models',
          },
          schema = {
            model = {
              default = 'kimi-k2.5',
            },
          },
        })
      end,
      txyun_minimax = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          name = 'txyun_minimax',
          env = {
            url = 'https://api.lkeap.cloud.tencent.com/plan/v3',
            api_key = function()
              return os.getenv('TX_API_KEY')
            end,
            chat_url = '/chat/completions',
          },
          schema = {
            model = {
              default = 'minimax-m2.7',
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
})

vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  require('codecompanion').actions({})
  vim.cmd.stopinsert()
end, { desc = 'CodeCompanionActions', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'CodeCompanionChat Toggle', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion /custom_chat<cr>', { desc = 'CodeCompanion CustomChat', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ar', '<cmd>CodeCompanionChat refresh<cr>', { desc = 'CodeCompanionChat refresh', noremap = true, silent = true })
vim.keymap.set('v', '<leader>al', '<cmd>CodeCompanionChat Add<cr>', { desc = 'CodeCompanionChat Add', noremap = true, silent = true })
