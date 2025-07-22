---@type vim.lsp.Config
return {
  single_file_support = true,
  on_attach = function(client, _)
    -- Only above 3.0.3
    client.server_capabilities.semanticTokensProvider.full = true
  end,
}
