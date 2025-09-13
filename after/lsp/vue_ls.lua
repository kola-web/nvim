-- vue3

---@type vim.lsp.Config
return {
  on_attach = function(client, _)
    if client.server_capabilities == nil then
      return
    end

    client.server_capabilities.documentFormattingProvider = nil
  end,
}
