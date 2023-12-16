return {
  cmd = {
    'lua-language-server',
    '--locale=zh-cn',
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
