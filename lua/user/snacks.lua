-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

local M = {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = function()
      local normal = {
        on_show = function()
          vim.cmd.stopinsert()
        end,
      }

      return {
        bigfile = {
          enabled = true,
          size = 0.5 * 1024 * 1024, -- 0.5MB
          setup = function(ctx)
            if vim.fn.exists(':NoMatchParen') ~= 0 then
              vim.cmd([[NoMatchParen]])
            end
            Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
          end,
        },
        dashboard = {
          enabled = true,

          preset = {
            pick = function(cmd, opts)
              return LazyVim.pick(cmd, opts)()
            end,
            keys = {
              { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
              { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
              { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
              { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
              { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
              { icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras' },
              { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
              { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
          },
        },
        explorer = {
          enabled = true,
        },
        git = { enabled = true },
        input = { enabled = true },
        indent = {
          enabled = true,
          indent = { only_current = true },
          scope = { only_current = true },
        },
        image = { enabled = false },
        lazygit = { enabled = false },
        notifier = { enabled = true, level = vim.log.levels.TRACE },
        picker = {
          enabled = true,
          sort = {
            fields = { 'score:desc', 'idx' },
          },
          formatters = {
            file = {
              truncate = 100,
            },
          },
          exclude = {
            '.git',
            '.svn',
            '.DS_store',
            'node_modules',
            'miniprogram_npm',
            '.yarn',
            '.dist',
            'dist',
            'dist_uat',
            'dist_pro',
          },
          win = {
            input = {
              keys = {
                ['l'] = 'confirm',
                ['<c-t>'] = {
                  'lopen',
                  mode = { 'n', 'i' },
                },
                ['<c-j>'] = {
                  'history_forward',
                  mode = { 'n', 'i' },
                },
                ['<c-k>'] = {
                  'history_back',
                  mode = { 'n', 'i' },
                },
                ['<c-v>'] = '',
                ['<c-l>'] = { 'focus_preview', mode = { 'n', 'i' } },
              },
            },
            list = {
              keys = {
                ['l'] = 'confirm',
                ['<c-l>'] = { 'focus_preview', mode = { 'n', 'i' } },
              },
            },
            preview = {
              keys = {
                ['<c-h>'] = { 'focus_list', mode = { 'n', 'i' } },
              },
            },
          },
          actions = {
            lopen = Snacks.picker.actions.loclist,
          },
          sources = {
            buffers = vim.tbl_deep_extend('force', normal, {}),
            colorschemes = vim.tbl_deep_extend('force', normal, {}),
            undo = vim.tbl_deep_extend('force', normal, {}),
            marks = vim.tbl_deep_extend('force', normal, {}),
            lsp_symbols = vim.tbl_deep_extend('force', normal, {}),
            lsp_workspace_symbols = vim.tbl_deep_extend('force', normal, {}),
            projects = vim.tbl_deep_extend('force', normal, {}),
            recent = vim.tbl_deep_extend('force', normal, {}),
            explorer = {
              hidden = true,
              ignored = true,
            },
          },
        },
        profiler = { enabled = true },
        quickfile = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        statuscolumn = {
          enabled = true,
        },
        terminal = {
          win = {
            keys = {
              nav_h = { '<C-h>', term_nav('h'), desc = 'Go to Left Window', expr = true, mode = 't' },
              nav_j = { '<C-j>', term_nav('j'), desc = 'Go to Lower Window', expr = true, mode = 't' },
              nav_k = { '<C-k>', term_nav('k'), desc = 'Go to Upper Window', expr = true, mode = 't' },
              nav_l = { '<C-l>', term_nav('l'), desc = 'Go to Right Window', expr = true, mode = 't' },
              hide_slash = { '<C-\\>', 'hide', desc = 'Hide Terminal', mode = { 't', 'n' } },
              hide_underscore = { '<c-_>', 'hide', desc = 'which_key_ignore', mode = { 't', 'n' } },
            },
          },
        },
        words = { enabled = true },
        scratch = {
          win_by_ft = {
            typescript = {
              keys = {
                ['source'] = {
                  '<cr>',
                  function(self)
                    vim.cmd('write')
                    local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                    local result = vim.system(command, { text = true }):wait()
                    require('utils').scratch_result(result)
                  end,
                  desc = 'Source buffer',
                  mode = { 'n', 'x' },
                },
              },
            },
            javascript = {
              keys = {
                ['source'] = {
                  '<cr>',
                  function(self)
                    vim.cmd('write')
                    local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                    local result = vim.system(command, { text = true }):wait()
                    require('utils').scratch_result(result)
                  end,
                  desc = 'Source buffer',
                  mode = { 'n', 'x' },
                },
              },
            },
            python = {
              keys = {
                ['source'] = {
                  '<cr>',
                  function(self)
                    vim.cmd('write')
                    local command = { 'python', vim.api.nvim_buf_get_name(self.buf) }
                    local result = vim.system(command, { text = true }):wait()
                    require('utils').scratch_result(result)
                  end,
                  desc = 'Source buffer',
                  mode = { 'n', 'x' },
                },
              },
            },
          },
        },
        zen = {
          toggles = {
            dim = false,
          },
        },
      }
    end,
    -- stylua: ignore
    keys = {
      {'<leader>c',  function() Snacks.bufdelete() end,                                                              desc = 'buf del', mode = { 'n' } },
      {'<leader>bo', function() Snacks.bufdelete.other() end,                                                        desc = 'buf del other', mode = { 'n' } },
      {'<leader>D',  function() Snacks.dashboard.open() end,                                                         desc = 'dashboard', mode = { 'n' } },
      {'<leader>z',  function() Snacks.zen() end,                                                                    desc = 'zen modal', mode = { 'n' } },
      {'<leader>Z',  function() Snacks.zen.zoom() end,                                                               desc = 'Toggle Zoom' },
      {'<leader>gb', function() Snacks.git.blame_line() end,                                                         desc = 'git blame line', mode = { 'n' } },
      {'<leader>n',  function() Snacks.notifier.show_history() end,                                                  desc = 'Notification History' },
      {'<leader>S',  function() Snacks.scratch.select() end,                                                         desc = 'Select Scratch Buffer' },
      {'<leader>un', function() Snacks.notifier.hide() end,                                                          desc = 'Dismiss All Notifications' },
      {'<C-\\>',     function() Snacks.terminal() end,                                                               desc = 'Toggle Terminal' },

      {'<leader>f',  function() Snacks.picker.files({ hidden = true, args = { '--path-separator', '/' } }) end,      desc = 'Find Files' },
      {'<leader>F',  function() Snacks.picker.grep({ layout = { preset = 'ivy' } }) end,                             desc = 'Grep' },
      {'<leader>bb', function() Snacks.picker.buffers() end,                                                         desc = 'Buffers' },
      {'<leader>sc', function() Snacks.picker.colorschemes() end,                                                    desc = '[S]earch [C]olorschemes' },
      {'<leader>su', function() Snacks.picker.undo() end,                                                            desc = '[S]earch [U]ndo ' },
      {'<leader>sU', function() Snacks.picker.resume() end,                                                          desc = '[S]earch [R]esume' },
      {'<leader>sk', function() Snacks.picker.keymaps() end,                                                         desc = '[S]earch [K]eymaps' },
      {'<leader>sm', function() Snacks.picker.marks() end,                                                           desc = '[S]earch [M]arks' },
      {'<leader>sH', function() Snacks.picker.highlights() end,                                                      desc = 'highlights' },
      {'<leader>sh', function() Snacks.picker.recent() end,                                                          desc = 'recent' },
      {'<leader>sl', function() Snacks.picker.loclist() end,                                                         desc = "Location List" },
      {'<leader>sq', function() Snacks.picker.qflist() end,                                                          desc = "Quickfix List" },
      {'<leader>sd', function() Snacks.picker.diagnostics() end,                                                     desc = "Diagnostics" },
      {'<leader>sD', function() Snacks.picker.diagnostics_buffer() end,                                              desc = "Buffer Diagnostics" },
      {'<leader>s/', function() Snacks.picker.grep_buffers() end,                                                    desc = "Grep Open Buffers" },

      {'<leader>be', function() Snacks.explorer() end,                                                               desc = 'explorer' },
      {'<leader>lt', require('utils').select_filetype,                                                               desc = 'select filetype' },
      {'<leader>pp', function () Snacks.picker.projects() end,                                                       desc = 'select projects' },

      {"gd", function() Snacks.picker.lsp_definitions() end,                                                         desc = "Goto Definition" },
      {"gD", function() Snacks.picker.lsp_declarations() end,                                                        desc = "Goto Declaration" },
      {"gr", function() Snacks.picker.lsp_references() end, nowait = true,                                           desc = "References" },
      {"gI", function() Snacks.picker.lsp_implementations() end,                                                     desc = "Goto Implementation" },
      {"gy", function() Snacks.picker.lsp_type_definitions() end,                                                    desc = "Goto T[y]pe Definition" },
      {'<leader>so',  function() Snacks.picker.lsp_symbols(require('utils').kind_filter) end,                        desc = 'LSP Symbols' },
      {'<leader>sO',  function() Snacks.picker.lsp_workspace_symbols(require('utils').kind_filter) end,              desc = 'LSP Workspace Symbols' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
          Snacks.toggle.diagnostics():map('<leader>ud')
          Snacks.toggle.line_number():map('<leader>ul')
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal Level' }):map('<leader>uc')
          Snacks.toggle.option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'Tabline' }):map('<leader>uA')
          Snacks.toggle.treesitter():map('<leader>uT')
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
          Snacks.toggle.dim():map('<leader>uD')
          Snacks.toggle.animate():map('<leader>ua')
          Snacks.toggle.indent():map('<leader>ug')
          Snacks.toggle.scroll():map('<leader>uS')
          Snacks.toggle.inlay_hints():map('<leader>uh')
          Snacks.toggle.zoom():map('<leader>uZ')
          Snacks.toggle.zen():map('<leader>uz')
        end,
      })
    end,
  },
}

return M
