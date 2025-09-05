-- vue3

---@type vim.lsp.Config
return {
  on_attach = function(client)
    if vim.bo.filetype == 'vue' then
      client.server_capabilities.semanticTokensProvider.full = false
    else
      client.server_capabilities.semanticTokensProvider.full = true
    end
  end,
}
