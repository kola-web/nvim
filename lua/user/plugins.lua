local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { 'folke/lazy.nvim', tag = 'stable' },
  -- My plugins here
  { 'nvim-lua/plenary.nvim' }, -- Useful lua functions used by lots of plugins
  { 'windwp/nvim-autopairs' }, -- Autopairs, integrates with both cmp and treesitter
  { 'numToStr/Comment.nvim' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'kyazdani42/nvim-tree.lua' },
  { 'famiu/bufdelete.nvim' },
  { 'akinsho/bufferline.nvim', branch = 'main' },
  { 'nvim-lualine/lualine.nvim' },
  { 'lewis6991/impatient.nvim' },
  { 'goolord/alpha-nvim', event = 'VimEnter' },
  { 'folke/which-key.nvim' },
  { 'aserowy/tmux.nvim' },
  { 'windwp/nvim-spectre' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'LunarVim/bigfile.nvim', event = { 'FileReadPre', 'BufReadPre', 'User FileOpened' } },

  { 'kana/vim-textobj-user' },
  { 'kola-web/vim-indent-object' },
  { 'kana/vim-textobj-entire', dependencies = { 'kana/vim-textobj-user' } },
  { 'whatyouhide/vim-textobj-xmlattr', dependencies = { 'kana/vim-textobj-user' } },
  { 'glts/vim-textobj-comment', dependencies = { 'kana/vim-textobj-user' } },
  { 'wellle/targets.vim' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'gbprod/substitute.nvim' },
  { 'andymass/vim-matchup' },
  { 'phaazon/hop.nvim', branch = 'v2' },
  { 'mg979/vim-visual-multi' },

  -- Colorschemes
  { 'folke/tokyonight.nvim' },
  { 'sainnhe/gruvbox-material' },

  -- cmp plugins
  { 'hrsh7th/nvim-cmp' }, -- The completion plugin
  { 'hrsh7th/cmp-buffer' }, -- buffer completions
  { 'hrsh7th/cmp-path' }, -- path completions
  { 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-cmdline' },
  { 'RRethy/vim-illuminate', lazy = true },

  -- snippets
  { 'L3MON4D3/LuaSnip' }, --snippet engine
  { 'rafamadriz/friendly-snippets' }, -- a bunch of snippets to

  -- LSP
  { 'onsails/lspkind-nvim' }, -- vscode-like pictograms
  { 'neovim/nvim-lspconfig', lazy = true, dependencies = { 'mason-lspconfig.nvim' } }, -- enable LSP
  { 'williamboman/mason.nvim', lazy = true },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'j-hui/fidget.nvim' },
  { 'jayp0521/mason-null-ls.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim', lazy = true, dependencies = { 'mason-null-ls.nvim' } }, -- for formatters and linters
  { 'windwp/nvim-ts-autotag' },
  { 'b0o/schemastore.nvim', lazy = true },
  { 'glepnir/lspsaga.nvim', event = 'BufRead', dependencies = { 'nvim-web-devicons', 'nvim-treesitter' } },

  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'ibhagwan/fzf-lua' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' },
  { 'lukas-reineke/indent-blankline.nvim', event = 'User FileOpened' },

  -- Git
  { 'lewis6991/gitsigns.nvim' },

  -- mark
  { 'chentoast/marks.nvim' },
  { 'folke/todo-comments.nvim' },

  -- code run
  { 'CRAG666/code_runner.nvim' },

  -- markdown
  { 'toppair/peek.nvim', build = 'deno task --quiet build:fast' },
  { 'dhruvasagar/vim-table-mode' },
}
