---@type vim.lsp.Config
return {
  on_attach = function(client, _)
    -- Only above 3.0.3
    client.server_capabilities.semanticTokensProvider.full = true
  end,
}
