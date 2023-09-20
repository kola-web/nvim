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
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
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
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = false, -- show help message on the command line when the popup is visible
    -- triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
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
    -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ['e'] = {
      function()
        require('neo-tree.command').execute({ toggle = true })
      end,
      'Explorer',
    },
    ['w'] = { '<cmd>w!<CR>', 'Save' },
    -- ['q'] = { '<cmd>q!<CR>', 'Quit' },
    -- ["c"] = { "<cmd>bd<CR>", "Close Buffer" },
    ['c'] = {
      function()
        require('mini.bufremove').delete(0, false)
      end,
      'Close Buffer',
    },
    ['h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
    ['o'] = { '<cmd>Lspsaga outline<CR>', 'Symbols' },
    ['/'] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<cr>', 'Comment' },
    ['f'] = {
      '<cmd> Telescope find_files <CR>',
      'Find files',
    },
    -- ["f"] = {
    --   "<cmd> FzfLua files <CR>",
    --   "Find files",
    -- },
    ['F'] = { '<cmd>Telescope live_grep theme=ivy<cr>', 'Find Text' },
    -- ["F"] = { "<cmd>FzfLua live_grep theme=ivy<cr>", "Find Text" },
    -- ['m'] = {
    --   function()
    --     vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    --   end,
    --   'Format',
    -- },
    -- ["m"] = { "<cmd>GuardFmt<cr>", "Format" },
    -- ["m"] = { "<cmd>GuardFmt<cr>", "Format" }, -- ["m"] = { "<cmd>GuardFmt<cr>", "Format" },
    [';'] = { '<cmd>Alpha<cr>', 'Alpha' },

    b = {
      name = 'Buffers',
      b = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        'Buffers',
      },
      o = {
        '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>',
        'closeOtherBuffer',
      },
      s = { '<cmd>BufferLinePick<cr>', 'Jump' },
      c = {
        '<cmd>BufferLinePickClose<cr>',
        'Pick which buffer to close',
      },
      e = { '<cmd>BufferLineCloseLeft<cr>', 'Close all to the left' },
      q = {
        '<cmd>BufferLineCloseRight<cr>',
        'Close all to the right',
      },
      D = {
        '<cmd>BufferLineSortByDirectory<cr>',
        'Sort by directory',
      },
      L = {
        '<cmd>BufferLineSortByExtension<cr>',
        'Sort by language',
      },
      h = { require('smart-splits').swap_buf_left, 'swap_buf_left' },
      j = { require('smart-splits').swap_buf_down, 'swap_buf_down' },
      k = { require('smart-splits').swap_buf_up, 'swap_buf_up' },
      l = { require('smart-splits').swap_buf_right, 'swap_buf_right' },
    },
    p = {
      name = 'Projects',
      p = { '<cmd>Telescope oldfiles<cr>', 'history file' },
      m = { '<cmd>PeekOpen<cr>', 'PeekOpen' },
      c = { '<cmd>PeekClose<cr>', 'PeekClose' },
      a = { vim.lsp.buf.add_workspace_folder, 'add_workspace_folder' },
    },
    P = {
      name = 'Plugins',
      i = { '<cmd>Lazy install<cr>', 'Install' },
      s = { '<cmd>Lazy sync<cr>', 'Sync' },
      S = { '<cmd>Lazy clear<cr>', 'Status' },
      c = { '<cmd>Lazy clean<cr>', 'Clean' },
      u = { '<cmd>Lazy update<cr>', 'Update' },
      p = { '<cmd>Lazy profile<cr>', 'Profile' },
      l = { '<cmd>Lazy log<cr>', 'Log' },
      d = { '<cmd>Lazy debug<cr>', 'Debug' },
    },

    r = {
      name = 'Replace',
      d = { '<cmd>%s/<div/<view/g<cr><cmd>%s/<\\/div/<\\/view/g<cr>', 'div->view' },
      v = { '<cmd>%s/<view/<div/g<cr><cmd>%s/<\\/view/<\\/div/g<cr>', 'view->div' },
      p = { '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%d",submatch(1))."rpx"#g<cr>', 'px-->rpx' },
      w = { '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1))."px"#g<cr>', 'rpx-->px' },
      e = { '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1) / 2)."px"#g<cr>', 'rpx/2-->px' },
      o = { '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%f",submatch(1) / 100.0)."rem"#g<cr>', 'px-->rem' },
      c = { '<cmd>RunClose <cr>', 'run close' },
      r = { '<cmd>RunFile <cr>', 'run file' },
      m = {
        "<cmd><c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>",
        'run file',
      },
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
      G = {
        name = 'Gist',
        a = { '<cmd>Gist -b -a<cr>', 'Create Anon' },
        d = { '<cmd>Gist -d<cr>', 'Delete' },
        f = { '<cmd>Gist -f<cr>', 'Fork' },
        g = { '<cmd>Gist -b<cr>', 'Create' },
        l = { '<cmd>Gist -l<cr>', 'List' },
        p = { '<cmd>Gist -b -p<cr>', 'Create Private' },
      },
    },

    l = {
      name = 'LSP',
      -- a = { vim.lsp.buf.code_action, 'Code Action' },
      a = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
      -- d = { '<cmd>TroubleToggle<cr>', 'diagnostic_setloclist' },
      D = { '<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>', 'diagnostic_setloclist' },
      d = { '<cmd>Lspsaga show_buf_diagnostics ++normal<cr>', 'diagnostic_setloclist' },
      -- n = { vim.diagnostic.goto_next, 'Netx Errors' },
      -- N = { vim.diagnostic.goto_prev, 'Prev Errors' },
      n = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Netx Errors' },
      N = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Prev Errors' },
      e = {
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        'Netx Errors',
      },
      E = {
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        'Prev Errors',
      },
      -- r = { vim.lsp.buf.rename, 'Rename' },
      r = { '<cmd>Lspsaga rename<cr>', 'Rename' },
      t = { '<cmd>Telescope filetypes<cr>', 'filetypes' },
      -- i = { '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', 'incoming_calls' },
      -- o = { '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', 'outgoing_calls' },
      i = { '<cmd>Lspsaga incoming_calls<CR>', 'incoming_calls' },
      o = { '<cmd>Lspsaga outgoing_calls<CR>', 'outgoing_calls' },
      I = { '<cmd>LspInstallInfo<cr>', 'LspInstallInfo' },
      c = {
        function()
          fun.compare_to_clipboard()
        end,
        'clip',
      },
    },

    s = {
      name = 'Search',
      T = {
        function()
          require('base46').toggle_theme()
        end,
        'Colorscheme',
      },
      t = { '<cmd>TodoTrouble<cr>', 'todoList' },
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
      h = { '<cmd>Telescope help_tags<cr>', 'Help' },
      i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", 'Media' },
      l = { '<cmd>Telescope resume<cr>', 'Last Search' },
      M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Recent File' },
      R = { '<cmd>Telescope registers<cr>', 'Registers' },
      k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
      C = { '<cmd>Telescope commands<cr>', 'Commands' },
      s = {
        function()
          require('spectre').open()
        end,
        'replace',
      },
      w = {
        function()
          require('spectre').open_visual({ select_word = true })
        end,
        'replace',
      },
      b = {
        function()
          require('spectre').open_file_search()
        end,
        'replace',
      },
    },

    S = {
      name = 'SnipRun',
      c = { '<cmd>SnipClose<cr>', 'Close' },
      n = { '<cmd>%SnipRun<cr>', 'Run File' },
      i = { '<cmd>SnipInfo<cr>', 'Info' },
      m = { '<cmd>SnipReplMemoryClean<cr>', 'Mem Clean' },
      r = { '<cmd>SnipReset<cr>', 'Reset' },
      t = { '<cmd>SnipRunToggle<cr>', 'Toggle' },
      x = { '<cmd>SnipTerminate<cr>', 'Terminate' },
    },

    T = {
      name = 'Treesitter',
      h = { '<cmd>TSHighlightCapturesUnderCursor<cr>', 'Highlight' },
      l = { '<cmd>TSNodeUnderCursor<cr>', 'UnderCursor' },
      p = { '<cmd>TSPlaygroundToggle<cr>', 'Playground' },
    },
    q = {
      t = { '<cmd>.!pbpaste | quicktype -l typescript --just-types  <cr>', 'typescript' },
    },
    [' '] = {
      name = 'flash',
      s = {
        function()
          require('flash').jump()
        end,
        'jump',
      },
      h = {
        function()
          require('flash').jump({ continue = true })
        end,
        'jump',
      },
      w = {
        function()
          require('flash').jump({
            pattern = vim.fn.expand('<cword>'),
          })
        end,
        'jump Word',
      },
      -- s = { '<cmd>HopChar2<cr>', 'HopChar2' },
      -- ['/'] = { '<cmd>HopPattern<cr>', 'HopPattern' },
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
      -- L = { '<cmd>HopLine<cr>', 'HopLineStart' },
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
  }

  which_key.setup(setup)
  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
