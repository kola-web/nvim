local M = {
  'neovim/nvim-lspconfig',
  lazy = false,
  event = { 'BufReadPre' },
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
    {
      'folke/neoconf.nvim',
    },
    {
      'williamboman/mason.nvim',
    },
    {
      'williamboman/mason-lspconfig.nvim',
    },
    {
      'folke/neodev.nvim',
    },
  },
}

local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status then
  return
end
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
    -- stylua: ignore start
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true, desc = "GoTo declaration" })
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true, desc = "GoTo definition" })
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Hover" })
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true, desc = "GoTo implementation" })
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true, desc = "GoTo references" })
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true, desc = "Float diagnostic" })
    keymap(bufnr, "n", "<leader>lI", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "Mason" })
    keymap(bufnr, "n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", { noremap = true, silent = true, desc = "Lsp incoming_calls" })
    keymap(bufnr, "n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", { noremap = true, silent = true, desc = "Lsp code_action" })
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, silent = true, desc = "Code action" })
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { noremap = true, silent = true, desc = "Next diagnostic" })
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { noremap = true, silent = true, desc = "Previous diagnostic" })
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = "Rename" })
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true, desc = "Signature help" })
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true, desc = "Setloclist" })
  -- stylua: ignore end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  require('illuminate').on_attach(client)
end

function M.config()
  require('neoconf').setup({})
  require('neodev').setup({})

  local lspconfig = require('lspconfig')

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      local server_config = {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
      }
      if require('neoconf').get(server_name .. '.disable') then
        return
      end
      if server_name == 'tsserver' then
        return
      end
      local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
      if require_ok then
        server_config = vim.tbl_deep_extend('force', conf_opts, server_config)
      end
      lspconfig[server_name].setup(server_config)
    end,
  })

  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
      suffix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

return M
