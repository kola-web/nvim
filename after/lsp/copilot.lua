---@type vim.lsp.Config
return {
  handlers = {
    ['window/showMessageRequest'] = (function(overridden)
      return function(err, params, ctx)
        if params.message:match([[^You've reached.*limit.*Upgrade.*$]]) then
          -- ignore
          Snacks.notify.notify(params.message)
          vim.lsp.enable('copilot', false)
          return vim.NIL
        end
        return overridden(err, params, ctx)
      end
    end)(vim.lsp.handlers['window/showMessageRequest']),
  },
}
