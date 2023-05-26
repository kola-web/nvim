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
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
  keymap(bufnr, "n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  keymap(bufnr, "n", "gT", "<cmd>Lspsaga peek_type_definition<CR>", opts)
  keymap(bufnr, "n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>")
end

M.on_attach = function(client, bufnr)
  -- lua_ls
  local arr = {}
  local noFormat = not table.concat(arr, ","):find(client.name)

  if noFormat then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end

  lsp_keymaps(bufnr)
  require("illuminate").on_attach(client)
end

return M
