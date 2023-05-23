local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "", type = "Error" },
    { name = "DiagnosticSignWarn", text = "", type = "Warn" },
    { name = "DiagnosticSignHint", text = "", type = "Hint" },
    { name = "DiagnosticSignInfo", text = "", type = "Info" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      source = "always",
    }, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  -- local opts = { noremap = true, silent = true }
  -- local keymap = vim.api.nvim_buf_set_keymap
  -- keymap(bufnr, 'n', 'gD', '<cmd>Telescope lsp_declarations<CR>', opts)
  -- keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  -- keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- keymap(bufnr, 'n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  -- keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  -- keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

M.on_attach = function(client, bufnr)
  -- lua_ls
  local arr = {}
  local noFormat = not table.concat(arr, ","):find(client.name)

  if noFormat then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end

  lsp_keymaps(bufnr)
end

return M
