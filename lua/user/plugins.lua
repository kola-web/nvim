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
  -- My plugins here
  { 'nvim-lua/plenary.nvim' }, -- Useful lua functions used by lots of plugins
  { 'windwp/nvim-autopairs' }, -- Autopairs, integrates with both cmp and treesitter
  { 'numToStr/Comment.nvim' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'kyazdani42/nvim-tree.lua' },
  { 'famiu/bufdelete.nvim' },
  { 'akinsho/bufferline.nvim' },
  { 'nvim-lualine/lualine.nvim' },
  { 'lewis6991/impatient.nvim' },
  { 'goolord/alpha-nvim' },
  { 'folke/which-key.nvim' },
  { 'aserowy/tmux.nvim' },
  { 'windwp/nvim-spectre' },
  { 'norcalli/nvim-colorizer.lua' },
  --  { 'editorconfig/editorconfig-vim' },

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

  -- Colorschemes
  { 'folke/tokyonight.nvim' },
  { 'catppuccin/nvim', as = 'catppuccin' },
  { 'projekt0n/github-nvim-theme' },
  { 'ellisonleao/gruvbox.nvim' },

  -- cmp plugins
  { 'hrsh7th/nvim-cmp' }, -- The completion plugin
  { 'hrsh7th/cmp-buffer' }, -- buffer completions
  { 'hrsh7th/cmp-path' }, -- path completions
  { 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-cmdline' },
  { 'tzachar/cmp-tabnine', build = './install.sh' },
  { 'RRethy/vim-illuminate' },

  -- snippets
  { 'L3MON4D3/LuaSnip' }, --snippet engine
  { 'rafamadriz/friendly-snippets' }, -- a bunch of snippets to

  -- LSP
  --  { "williamboman/nvim-lsp-installer",  }, -- simple to  language server installer
  { 'onsails/lspkind-nvim' }, -- vscode-like pictograms
  { 'neovim/nvim-lspconfig' }, -- enable LSP
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'j-hui/fidget.nvim' },
  { 'jayp0521/mason-null-ls.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' }, -- for formatters and linters
  { 'windwp/nvim-ts-autotag' },
  { 'b0o/schemastore.nvim' },
  { 'glepnir/lspsaga.nvim', branch = 'main' },

  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'ibhagwan/fzf-lua' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' },
  { 'lukas-reineke/indent-blankline.nvim' },

  -- Git
  { 'lewis6991/gitsigns.nvim' },

  -- DAP
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'ravenxrz/DAPInstall.nvim' },

  -- mark
  { 'chentoast/marks.nvim' },

  -- code run
  { 'CRAG666/code_runner.nvim' },

  -- markdown
  { 'toppair/peek.nvim', build = 'deno task --quiet build:fast' },
  { 'dhruvasagar/vim-table-mode' },
}
