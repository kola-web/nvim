vim.pack.add({
  'https://github.com/github/copilot.vim',
  'https://github.com/monkoose/neocodeium',
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/ravitemer/codecompanion-history.nvim',
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
    diff = {
      provider = 'snacks',
    },
    chat = {
      icons = {
        chat_fold = '',
      },
      fold_reasoning = true,
      show_reasoning = true,
    },
  },
  interactions = {
    chat = {
      adapter = 'txyun_glm',
      keymaps = {
        close = { modes = { n = 'q', i = '<C-c>' } },
        stop = { modes = { n = '<C-c>' } },
      },
      opts = {
        context_management = {
          enabled = true,
        },
      },
      tools = {
        opts = {
          auto_approve = true,
          default_tools = { 'tools' },
        },
        groups = {
          ['tools'] = {
            description = 'commonly used tools',
            prompt = "I'm giving you access to the ${tools} to help you perform coding tasks",
            tools = {
              'read_file',
              'cmd_runner',
              'create_file',
              'file_search',
              'grep_search',
              'list_code_usages',
              'get_changed_files',
              'insert_edit_into_file',
            },
          },
        },
      },
    },
    inline = { adapter = 'opencode' },
    agent = { adapter = 'opencode' },
  },
  adapters = {
    acp = {
      opencode = function()
        return require('codecompanion.adapters').extend('opencode', {
          name = 'opencode',
          formatted_name = 'OpenCode',
          commands = {
            default = { 'opencode', 'acp' },
          },
        })
      end,
    },
    http = {
      txyun_glm = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          name = 'txyun_glm',
          env = {
            url = 'https://api.lkeap.cloud.tencent.com/plan/v3',
            api_key = function()
              return os.getenv('TX_API_KEY')
            end,
            chat_url = '/chat/completions',
            models_endpoint = '/models',
          },
          handlers = {
            --- Override chat_output to:
            ---   1. Parse reasoning_content from GLM's streaming response (same as DeepSeek)
            ---   2. Suppress empty/whitespace-only content that creates blank lines
            ---
            --- We use chat_output instead of parse_message_meta because
            --- parse_message_meta is only called when result.extra exists,
            --- but pure-whitespace content chunks (e.g. content = "\n")
            --- often have no extra fields, so they bypass parse_message_meta.
            chat_output = function(self, data, tools)
              local result = require('codecompanion.adapters.http.openai').handlers.chat_output(self, data, tools)
              if result and result.status == 'success' then
                -- Map reasoning_content from extra to output.reasoning
                if result.extra and result.extra.reasoning_content then
                  result.output.reasoning = { content = result.extra.reasoning_content }
                end
                -- Suppress empty/whitespace-only content to prevent blank lines
                local content = result.output.content
                if content ~= nil then
                  if content == '' or content:match('^%s*$') then
                    result.output.content = nil
                  else
                    -- Trim leading newlines that create extra blank lines
                    -- when transitioning from reasoning to response
                    result.output.content = content:gsub('^\n+', '')
                    if result.output.content == '' then
                      result.output.content = nil
                    end
                  end
                end
              end
              return result
            end,
          },
          schema = {
            model = {
              default = 'glm-5-1',
            },
          },
        })
      end,
    },
  },
  prompt_library = {
    markdown = {
      dirs = {
        function()
          return vim.fn.getcwd() .. '/.prompts'
        end,
        vim.fn.stdpath('config') .. '/prompts',
      },
    },
  },
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = 'gh',
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = 'sc',
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = true,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface (auto resolved to a valid picker)
        picker = 'telescope', --- ("telescope", "snacks", "fzf-lua", or "default")
        ---Optional filter function to control which chats are shown when browsing
        chat_filter = nil, -- function(chat_data) return boolean end
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = 'r', i = '<M-r>' },
          delete = { n = 'd', i = '<M-d>' },
          duplicate = { n = '<C-y>', i = '<C-y>' },
        },
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to current chat adapter)
          adapter = nil, -- "copilot"
          ---Model for generating titles (defaults to current chat model)
          model = nil, -- "gpt-4o"
          ---Number of user prompts after which to refresh the title (0 to disable)
          refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
          ---Maximum number of times to refresh the title (default: 3)
          max_refreshes = 3,
          format_title = function(original_title)
            -- this can be a custom function that applies some custom
            -- formatting to the title.
            return original_title
          end,
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
        ---Enable detailed logging for history extension
        enable_logging = false,

        -- Summary system
        summary = {
          -- Keymap to generate summary for current chat (default: "gcs")
          create_summary_keymap = 'gcs',
          -- Keymap to browse summaries (default: "gbs")
          browse_summaries_keymap = 'gbs',

          generation_opts = {
            adapter = nil, -- defaults to current chat adapter
            model = nil, -- defaults to current chat model
            context_size = 90000, -- max tokens that the model supports
            include_references = true, -- include slash command content
            include_tool_outputs = true, -- include tool execution results
            system_prompt = nil, -- custom system prompt (string or function)
            format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
          },
        },

        -- Memory system (requires VectorCode CLI)
        memory = {
          -- Automatically index summaries when they are generated
          auto_create_memories_on_summary_generation = true,
          -- Path to the VectorCode executable
          vectorcode_exe = 'vectorcode',
          -- Tool configuration
          tool_opts = {
            -- Default number of memories to retrieve
            default_num = 10,
          },
          -- Enable notifications for indexing progress
          notify = true,
          -- Index all existing memories on startup
          -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
          index_on_startup = false,
        },
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
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanion /explain<cr>', { desc = 'CodeCompanion Explain', noremap = true, silent = true })
vim.keymap.set('v', '<leader>af', '<cmd>CodeCompanion /fix<cr>', { desc = 'CodeCompanion Fix', noremap = true, silent = true })
vim.keymap.set('v', '<leader>at', '<cmd>CodeCompanion /tests<cr>', { desc = 'CodeCompanion Tests', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ap', '<cmd>CodeCompanionCmd<cr>', { desc = 'CodeCompanion Cmd', noremap = true, silent = true })
