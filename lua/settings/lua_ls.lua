return {
  cmd = {
    'lua-language-server',
    '--locale=zh-cn',
  },
  settings = {
    Lua = {
      misc = {
        -- parameters = { "--loglevel=trace" },
      },
      -- hover = { expandAlias = false },
      type = {
        castNumberToInteger = true,
      },
      diagnostics = {
        disable = { 'incomplete-signature-doc', 'trailing-space' },
        -- enable = false,
        groupSeverity = {
          strong = 'Warning',
          strict = 'Warning',
        },
        groupFileStatus = {
          ['ambiguity'] = 'Opened',
          ['await'] = 'Opened',
          ['codestyle'] = 'None',
          ['duplicate'] = 'Opened',
          ['global'] = 'Opened',
          ['luadoc'] = 'Opened',
          ['redefined'] = 'Opened',
          ['strict'] = 'Opened',
          ['strong'] = 'Opened',
          ['type-check'] = 'Opened',
          ['unbalanced'] = 'Opened',
          ['unused'] = 'Opened',
        },
        unusedLocalExclude = { '_*' },
      },
    },
  },
}
