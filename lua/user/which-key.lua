local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
}

function M.config()
  local status_ok, which_key = pcall(require, 'which-key')
  if not status_ok then
    return
  end

  local fun = require('utils.init')

  local setup = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = 'Comments' },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    motions = {
      count = true,
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'rounded', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'center', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers_blacklist = {
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  }

  local opts = {
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ['w'] = { '<cmd>w!<CR>', 'Save' },
    ['q'] = { '<cmd>q!<CR>', 'Quit' },
    ['c'] = {
      function(n)
        require('mini.bufremove').delete(n, false)
      end,
      'Close Buffer',
    },
    o = { '<cmd>Outline<CR>', 'outline' },
    h = {
      '<Cmd>nohlsearch<Bar>diffupdate<Bar>syntax sync fromstart<CR>',
      'Redraw / clear hlsearch / diff update',
    },
    ['f'] = {
      '<cmd> FzfLua files <CR>',
      'Find files',
    },
    ['F'] = { '<cmd>Telescope live_grep theme=ivy<cr>', 'Find Text' },
    ['m'] = { fun.conformFormat, 'Format buffer' },
    [';'] = { '<cmd>Dashboard<cr>', 'Alpha' },
    ["'"] = { [[:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]], 'Modify the register' },

    a = {
      name = 'copilot',
      a = {
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        'CopilotChat - Quick chat',
      },
      h = {
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
          vim.api.nvim_input('<Esc>')
        end,
        'CopilotChat - Help actions',
      },
      p = {
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
          vim.api.nvim_input('<Esc>')
        end,
        'CopilotChat - Prompt actions',
      },
      o = {
        '<cmd>Copilot panel<cr>',
        'Copilot panel',
      },
      t = {
        '<cmd>CopilotChatToggle<cr>',
        'CopilotChat Toggle',
      },
    },
    b = {
      name = 'Buffers',
      b = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        'Buffers',
      },
      o = {
        '<cmd>BufferLineCloseOthers<cr>',
        'BufferCloseAllButCurrent',
      },
      h = { require('smart-splits').swap_buf_left, 'swap_buf_left' },
      j = { require('smart-splits').swap_buf_down, 'swap_buf_down' },
      k = { require('smart-splits').swap_buf_up, 'swap_buf_up' },
      l = { require('smart-splits').swap_buf_right, 'swap_buf_right' },
    },
    p = {
      name = 'Projects',
      h = { '<cmd>Telescope oldfiles<cr>', 'history file' },
      m = { '<cmd>PeekOpen<cr>', 'PeekOpen' },
      c = { '<cmd>PeekClose<cr>', 'PeekClose' },
      a = { vim.lsp.buf.add_workspace_folder, 'add_workspace_folder' },
    },
    r = {
      name = 'Replace',
      d = { '<cmd>%s/<div/<view/g<cr><cmd>%s/<\\/div/<\\/view/g<cr>', 'div->view' },
      v = { '<cmd>%s/<view/<div/g<cr><cmd>%s/<\\/view/<\\/div/g<cr>', 'view->div' },
      p = { '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%d",submatch(1))."rpx"#g<cr>', 'px-->rpx' },
      w = { '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1))."px"#g<cr>', 'rpx-->px' },
      e = { '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1) / 2)."px"#g<cr>', 'rpx/2-->px' },
      o = { '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%f",submatch(1) / 100.0)."rem"#g<cr>', 'px-->rem' },
      l = {
        '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%.2f",submatch(1) / 1080.0 * 750)."px"#g<cr>',
        '1080px-->750px',
      },
      m = {
        "<cmd><c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
        'run file',
      },
      a = { '<cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left><cr>', 'div->view' },
    },
    g = {
      name = 'Git',
      g = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        'Undo Stage Hunk',
      },
      o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
      b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
      c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
      d = {
        '<cmd>Gitsigns diffthis HEAD<cr>',
        'Diff',
      },
    },
    l = {
      name = 'LSP',
      l = { '<cmd>lua require("neogen").generate()<CR>', 'generate' },
      t = { '<cmd>Telescope filetypes<cr>', 'filetypes' },
      c = {
        function()
          fun.compare_to_clipboard()
        end,
        'clip',
      },
    },

    x = {
      name = '+diagnostics/quickfix',
      x = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document Diagnostics (Trouble)' },
      X = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics (Trouble)' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
      t = { '<cmd>TodoTrouble<cr>', 'Todo' },
      T = { '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', 'Todo/FIX/FIXME' },
    },

    s = {
      name = 'Search',
      t = { '<cmd>TodoTelescope<cr>', 'Todo' },
      T = { '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', 'Todo/Fix/Fixme' },
      f = {
        function()
          require('telescope').extensions.file_browser.file_browser({
            path = '%:p:h',
            cwd = vim.fn.expand('%:p:h'),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = 'normal',
            layout_config = { height = 40 },
          })
        end,
        'file_browser',
      },
      c = { '<cmd>Telescope colorscheme<cr>', 'colorscheme' },
      d = { '<cmd>Telescope diagnostics<cr>', 'diagnostics' },
      h = { '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<cr>', 'hidden file' },
      H = { '<cmd>Telescope help_tags<cr>', 'Help' },
      M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Recent File' },
      R = { '<cmd>Telescope registers<cr>', 'Registers' },
      k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
      s = {
        function()
          require('spectre').open()
        end,
        'replace',
      },
      b = {
        function()
          require('spectre').open_file_search()
        end,
        'replace',
      },
      p = {
        '<cmd>Telescope package_info<cr>',
        'package_info',
      },
    },
    i = {
      name = 'SnipRun',
      c = { '<cmd>SnipClose<cr>', 'Close' },
      i = { '<cmd>SnipRun<cr>', 'Run File' },
      d = { '<cmd>SnipInfo<cr>', 'Info' },
      m = { '<cmd>SnipReplMemoryClean<cr>', 'Mem Clean' },
      r = { '<cmd>SnipReset<cr>', 'Reset' },
      l = { '<cmd>SnipLive<cr>', 'snip live' },
    },
    n = {
      name = 'snippet',
      a = {
        function()
          require('scissors').addNewSnippet()
        end,
        'addSnippet',
      },
      e = {
        function()
          require('scissors').editSnippet()
        end,
        'editSnippet',
      },
    },
    [' '] = {
      name = 'flash',
      s = {
        function()
          require('flash').jump()
        end,
        'jump',
      },
      v = {
        function()
          require('flash').treesitter()
        end,
        'jump',
      },
      w = {
        function()
          fun.flashWord()
        end,
        'jump Word',
      },
      -- s = { '<cmd>HopChar2<cr>', 'HopChar2' },
      ['/'] = {
        function()
          require('flash').toggle()
        end,
        'HopPattern',
      },
      l = {
        function()
          require('flash').jump({
            search = { mode = 'search', max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = '^',
          })
        end,
        'jump line',
      },
    },
  }

  local vopts = {
    mode = 'v', -- VISUAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local vmappings = {
    ['/'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      'Comment',
    },
    S = { "<esc><cmd>'<,'>SnipRun<cr>", 'Run range' },
    s = {
      function()
        require('spectre').open()
      end,
      'replace',
    },
    q = {
      t = { "<esc><cmd>'<,'>!quicktype -l typescript --just-types <cr>", 'quicktype' },
    },
    i = {
      name = 'SnipRun',
      i = { "<cmd>'<,'>SnipRun<cr>", 'Run File' },
    },
  }

  which_key.setup(setup)
  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
