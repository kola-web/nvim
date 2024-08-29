-- This file is automatically loaded by plugins.core
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua', '.svn' }, 'cwd' }

local opt = vim.opt

opt.autowrite = true -- Enable auto write

opt.undofile = true -- Enable persistent undo (see also `:h undodir`)

opt.backup = false -- Don't store backup while overwriting the file
opt.writebackup = false -- Don't store backup while overwriting the file

vim.cmd('filetype plugin indent on')

opt.breakindent = true -- Indent wrapped lines to match line start
opt.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)

opt.ruler = false -- Don't show cursor position in command line
opt.showmode = false -- Dont show mode since we have a statusline
opt.wrap = false -- Display long lines as just one line

opt.signcolumn = 'yes' -- Always show sign column (otherwise it will shift text)
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',

  vert = '┃',
  horiz = '━',
  horizdown = '┳',
  horizup = '┻',
  verthoriz = '╋',
  vertleft = '┫',
  vertright = '┣',
}

opt.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
opt.incsearch = true -- Show search results while typing
opt.infercase = true -- Infer letter cases for a richer built-in keyword completion
opt.smartcase = true -- Don't ignore case when searching if pattern has upper case
opt.smartindent = true -- Make indenting smart

opt.completeopt = 'menu,menuone,noselect'
opt.virtualedit = 'block' -- Allow going past the end of line in visual block mode
opt.formatoptions = 'qjl1' -- Don't autoformat comments

opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Reduce command line messages
opt.splitkeep = 'screen' -- Reduce scroll during window split

opt.pumblend = 10 -- Make builtin completion menus slightly transparent
opt.pumheight = 10 -- Make popup menu smaller
opt.winblend = 10 -- Make floating windows slightly transparent

opt.listchars = {
  tab = '> ',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
} -- Define which helper symbols to show
opt.list = true -- Show some helper symbols

opt.clipboard = 'unnamedplus' -- Sync with system clipboard
-- opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.iskeyword:append('-,#') -- 将包含 `-,#` 的单词视为单个单词
opt.jumpoptions = 'view'
opt.laststatus = 3 -- global statusline
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.sidescrolloff = 8 -- Columns of context
opt.spelllang = { 'en', 'cjk' }
opt.spelloptions:append('noplainbuffer,camel')
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width

-- opt.whichwrap:append('<,>,[,],h,l') -- 允许在到达行首/行尾时使用的键

-- gui
opt.guifont = 'JetBrainsMono Nerd Font:h10' -- 在图形化的 neovim 应用程序中使用的字体

-- opt.foldlevelstart = 99
-- opt.foldlevel = 99

-- opt.foldtext = ''
-- opt.foldmethod = 'expr'
opt.foldmethod = 'indent'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_scale_factor = 1.4
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_no_idle = false

  vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
    vim.api.nvim_paste(vim.fn.getreg('+'), true, -1)
  end, { noremap = true, silent = true })
end

if vim.g.vscode then
  local vscode = require('vscode-neovim')
  vim.notify = vscode.notify
end
