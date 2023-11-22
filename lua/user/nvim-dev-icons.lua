local M = {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
}

function M.config()
  require('nvim-web-devicons').setup({
    override = {
      zsh = {
        icon = '',
        color = '#428850',
        cterm_color = '65',
        name = 'Zsh',
      },
    },
    color_icons = true,
    default = true,
  })
end

M.icons = {
  misc = {
    dots = '󰇘',
  },
  dap = {
    Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '.>',
  },
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
    Array = ' ',
    Boolean = '󰨙 ',
    Codeium = '󰘦 ',
    Control = ' ',
    Collapsed = ' ',
    Copilot = ' ',
    Key = ' ',
    Namespace = '󰦮 ',
    Null = ' ',
    Number = '󰎠 ',
    Object = ' ',
    Package = ' ',
    String = ' ',
  },
}

return M
