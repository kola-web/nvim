-- vue3

---@type vim.lsp.Config
return {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = nil
  end,
}
