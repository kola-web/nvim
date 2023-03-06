local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end
-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { 'wbthomason/packer.nvim' } -- Have packer manage itself
  use { 'nvim-lua/plenary.nvim' } -- Useful lua functions used by lots of plugins
  use { 'windwp/nvim-autopairs' } -- Autopairs, integrates with both cmp and treesitter
  use { 'numToStr/Comment.nvim' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'famiu/bufdelete.nvim' }
  use { 'akinsho/bufferline.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'lewis6991/impatient.nvim' }
  use { 'goolord/alpha-nvim' }
  use { 'folke/which-key.nvim' }
  use { 'aserowy/tmux.nvim' }
  use { 'windwp/nvim-spectre' }
  use { 'norcalli/nvim-colorizer.lua' }
  -- use { 'editorconfig/editorconfig-vim' }

  use { 'kola-web/vim-indent-object' }
  use { 'kana/vim-textobj-user' }
  use { 'whatyouhide/vim-textobj-xmlattr' }
  use { 'kana/vim-textobj-entire' }
  use { 'wellle/targets.vim' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-abolish' }
  use { 'gbprod/substitute.nvim' }
  use { 'andymass/vim-matchup' }
  use { 'phaazon/hop.nvim', branch = 'v2' }

  -- Colorschemes
  use { 'folke/tokyonight.nvim' }
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use { 'projekt0n/github-nvim-theme' }
  use { 'ellisonleao/gruvbox.nvim' }

  -- cmp plugins
  use { 'hrsh7th/nvim-cmp' } -- The completion plugin
  use { 'hrsh7th/cmp-buffer' } -- buffer completions
  use { 'hrsh7th/cmp-path' } -- path completions
  use { 'saadparwaiz1/cmp_luasnip' } -- snippet completions
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
  use { 'RRethy/vim-illuminate' }

  -- snippets
  use { 'L3MON4D3/LuaSnip' } --snippet engine
  use { 'rafamadriz/friendly-snippets' } -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer",  } -- simple to use language server installer
  use { 'onsails/lspkind-nvim' } -- vscode-like pictograms
  use { 'neovim/nvim-lspconfig' } -- enable LSP
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'j-hui/fidget.nvim' }
  use { 'jayp0521/mason-null-ls.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim' } -- for formatters and linters
  use { 'windwp/nvim-ts-autotag' }
  use { 'b0o/schemastore.nvim' }
  use { 'glepnir/lspsaga.nvim', branch = 'main' }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'ibhagwan/fzf-lua' }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- Git
  use { 'lewis6991/gitsigns.nvim' }

  -- DAP
  use { 'mfussenegger/nvim-dap' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'ravenxrz/DAPInstall.nvim' }

  -- mark
  use { 'chentoast/marks.nvim' }

  -- code run
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- markdown
  use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast' }
  use { 'dhruvasagar/vim-table-mode' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
