local M = {
  'neovim/nvim-lspconfig',
  lazy = true,
  dependencies = {
    { 'b0o/schemastore.nvim' },
    {
      'folke/neoconf.nvim',
    },
    {
      'williamboman/mason.nvim',
    },
    {
      'williamboman/mason-lspconfig.nvim',
    },
    { 'folke/neodev.nvim', config = true },
  },
  opts = {
    inlay_hints = {
      enabled = true,
    },
  },
}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

M.on_attach = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local keymap = vim.keymap.set

      local buffer = ev.buf
      -- stylua: ignore start
      keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo declaration" })
      keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo definition" })
      keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Hover" })
      keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo implementation" })
      -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo references" })
      keymap("n", "gr", "<cmd>lua require('trouble').toggle('lsp_references')<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo references" })
      keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Float diagnostic" })
      keymap("n", "<leader>lI", "<cmd>LspInfo<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Mason" })
      keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Lsp incoming_calls" })
      keymap("n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Lsp outgoing_calls" })
      keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Code action" })
      keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Next diagnostic" })
      keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Previous diagnostic" })
      keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Rename" })
      keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Signature help" })
      keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Setloclist" })
      keymap("n", "<leader>ld", "<cmd>TroubleToggle<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Setloclist" })
      -- stylua: ignore end
    end,
  })
end

function M.config()
  require('neoconf').setup({
    import = {
      vscode = false, -- local .vscode/settings.json
      coc = false, -- global/local coc-settings.json
      nlsp = false, -- global/local nlsp-settings.nvim json settings
    },
  })

  M.on_attach()

  local lspconfig = require('lspconfig')

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      -- if server_name == 'volar' then
      --   return
      -- end
      local server_config = {
        capabilities = lsp_capabilities,
      }
      local neoConfig = {}
      if server_name == 'emmet_language_server' then
        neoConfig = require('neoconf').get(server_name) or {}
      end

      local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
      if require_ok then
        server_config = vim.tbl_deep_extend('force', conf_opts, neoConfig, server_config) or {}
      end

      lspconfig[server_name].setup(server_config)
    end,
  })

  local signs = {
    { name = 'DiagnosticSignError', text = ' ' },
    { name = 'DiagnosticSignWarn', text = ' ' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = ' ' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = sign.name })
  end

  local config = {
    --  virtual text
    virtual_lines = true,
    virtual_text = {
      spacing = 4,
      source = 'always',
      prefix = '●',
      severity = {
        -- Specify a range of severities
        min = vim.diagnostic.severity.ERROR,
      },
    },
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      source = 'always',
    },
  }

  vim.diagnostic.config(config)
end

return M
