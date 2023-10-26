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
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
          '${3rd}/luv/library',
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
