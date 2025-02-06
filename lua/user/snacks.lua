local M = {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = function()
      -- Terminal Mappings
      local function term_nav(dir)
        ---@param self snacks.terminal
        return function(self)
          return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function()
            vim.cmd.wincmd(dir)
          end)
        end
      end

      return {
        bigfile = {
          enabled = true,
          size = 0.1 * 1024 * 1024, -- 0.1MB
        },
        dashboard = {
          enabled = true,
          sections = {
            { section = 'header' },
            { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
            { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
            { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
            { section = 'startup' },
          },
        },
        explorer = {
          enabled = true,
        },
        git = { enabled = true },
        input = { enabled = true },
        indent = { enabled = true },
        notifier = { enabled = true },
        picker = {
          enabled = true,
          exclude = {
            '.git',
            '.svn',
            '.DS_store',
            'node_modules',
            'miniprogram_npm',
            '.yarn',
            'dist',
            'dist_uat',
            'dist_pro',
          },
          win = {
            input = {
              keys = {
                ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
                ['s'] = { 'flash' },
                ['<c-t>'] = {
                  'trouble_open',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
          actions = {
            flash = function(picker)
              require('flash').jump({
                pattern = '^',
                label = { after = { 0, 0 } },
                search = {
                  mode = 'search',
                  exclude = {
                    function(win)
                      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                    end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              })
            end,
            trouble_open = require('trouble.sources.snacks').actions.trouble_open,
          },
        },
        quickfile = { enabled = true },
        -- scope = {
        --   enabled = false,
        -- },
        -- scroll = { enabled = true },
        statuscolumn = { enabled = true }, -- we set this in options.lua
        terminal = {
          win = {
            keys = {
              nav_h = { '<C-h>', term_nav('h'), desc = 'Go to Left Window', expr = true, mode = 't' },
              nav_j = { '<C-j>', term_nav('j'), desc = 'Go to Lower Window', expr = true, mode = 't' },
              nav_k = { '<C-k>', term_nav('k'), desc = 'Go to Upper Window', expr = true, mode = 't' },
              nav_l = { '<C-l>', term_nav('l'), desc = 'Go to Right Window', expr = true, mode = 't' },
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
                    local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                    local result = vim.system(command, { text = true }):wait()
                    Snacks.notify.info(result.stdout)
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
                    local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                    local result = vim.system(command, { text = true }):wait()
                    Snacks.notify.info(result.stdout)
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
    keys = {
      -- stylua: ignore start
      { '<leader>c',  function() Snacks.bufdelete() end,                                                       desc = 'buf del',          mode = { 'n' }},
      {'<leader>bo',  function() Snacks.bufdelete.other() end,                                                 desc = 'buf del other',    mode = { 'n' }},

      { '<leader>D',  function() Snacks.dashboard.open() end,                                                  desc = 'dashboard',        mode = { 'n' }},

      { '<leader>z',  function() Snacks.zen() end,                                                             desc = 'zen modal',        mode = { 'n' }},
      { '<leader>Z',  function() Snacks.zen.zoom() end,                                                        desc = 'Toggle Zoom' },
      {'<leader>gg',  function() Snacks.lazygit() end,                                                         desc = 'lazygit',          mode = { 'n' }},
      {'<leader>gl',  function() Snacks.lazygit.log() end,                                                     desc = 'lazygit log file', mode = { 'n' }},
      { "<leader>gf", function() Snacks.lazygit.log_file() end,                                                desc = "Lazygit Current File History" },
      {'<leader>gb',  function() Snacks.git.blame_line() end,                                                  desc = 'git blame line',   mode = { 'n' }},
      { "<leader>n",  function() Snacks.notifier.show_history() end,                                           desc = "Notification History" },
      { "<leader>.",  require("utils").scratch_open,                                                           desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,                                                  desc = "Select Scratch Buffer" },
      { "<leader>un", function() Snacks.notifier.hide() end,                                                   desc = "Dismiss All Notifications" },
      { "<C-\\>",     function() Snacks.terminal() end,                                                        desc = "Toggle Terminal" },

      { "<leader>f",  function() Snacks.picker.files({args = {'--path-separator', '/'}}) end,                                                    desc = "Find Files" },
      { "<leader>F",  function() Snacks.picker.grep({ layout = {  preset = "ivy" } }) end,                     desc = "Grep" },
      { "<leader>bb", function() Snacks.picker.buffers({ on_show = function() vim.cmd.stopinsert() end }) end, desc = "Buffers" },
      { "<leader>sc", function() Snacks.picker.colorschemes() end,                                             desc = "Colorschemes" },
      { "<leader>su", function() Snacks.picker.undo() end,                                                     desc = "Undo History" },
      { "<leader>o",  function() Snacks.picker.lsp_symbols() end,                                              desc = "LSP Symbols" },
      { "<leader>O",  function() Snacks.picker.lsp_workspace_symbols() end,                                    desc = "LSP Workspace Symbols" },

      { "<leader>E",  function() Snacks.explorer() end,                                                        desc = "explorer" },

      { "<leader>lt", require("utils").select_filetype,                                                           desc = "select filetype" },
      -- stylua: ignore end
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
          Snacks.toggle.zoom():map('<leader>wm'):map('<leader>uZ')
          Snacks.toggle.zen():map('<leader>uz')
        end,
      })
    end,
  },
}

return M
