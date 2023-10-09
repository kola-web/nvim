local M = {
  'neovim/nvim-lspconfig',
  lazy = true,
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
    {
      'glepnir/lspsaga.nvim',
    },
    {
      'b0o/schemastore.nvim',
    },
    {
      'williamboman/mason-lspconfig.nvim',
      lazy = true,
    },
  },
}

function M.config(_, opts)
  local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities = vim.tbl_deep_extend(
    'force',
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {}
  )

  for name, icon in pairs(require('icons').diagnostics) do
    name = 'DiagnosticSign' .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
  end

  local config = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = '●',
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    severity_sort = true,
  }

  vim.diagnostic.config(config)

  local function lsp_keymaps(bufnr)
    local key_opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set
    keymap('n', 'gr', '<cmd>Lspsaga finder<CR>', key_opts)
    keymap('n', 'gI', function()
      require('telescope.builtin').lsp_implementations({ reuse_win = true })
    end, key_opts)
    keymap('n', 'gy', function()
      require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
    end, key_opts)
    keymap('n', 'gD', vim.lsp.buf.declaration, key_opts)
    keymap('n', 'gd', vim.lsp.buf.definition, key_opts)
    keymap('n', 'K', vim.lsp.buf.hover, key_opts)
    keymap('n', 'gs', vim.lsp.buf.signature_help, key_opts)
    keymap('n', 'gl', vim.diagnostic.open_float, key_opts)
    keymap('n', '<leader>m', function()
      require('conform').format({ bufnr = bufnr, lsp_fallback = true })
    end, opts)
  end

  local lspconfig = require('lspconfig')
  local on_attach = function(client, bufnr)
    if client.name ~= 'lua_ls' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    if client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end
    lsp_keymaps(bufnr)
    require('illuminate').on_attach(client)
  end

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      Opts = {
        on_attach = on_attach,
        capabilities = vim.deepcopy(capabilities),
      }

      local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
      if require_ok then
        Opts = vim.tbl_deep_extend('force', conf_opts, Opts)
      end

      lspconfig[server_name].setup(Opts)
    end,
  })
end

return M
