-- PackChanged hooks must be defined BEFORE vim.pack.add()
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    -- Run TSUpdate after treesitter install/update
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  'https://github.com/ellisonleao/gruvbox.nvim',

  -- blink
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range("1.x")  },
  'https://github.com/kola-web/blink-alias-path',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/folke/lazydev.nvim',

  -- lsp
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/folke/neoconf.nvim',
  'https://github.com/b0o/schemastore.nvim',

  'https://github.com/stevearc/conform.nvim',

  'https://github.com/romgrk/barbar.nvim',

  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',

  'https://github.com/nvim-mini/mini.nvim',

  'https://github.com/folke/snacks.nvim',
})
