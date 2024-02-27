return {
  'SmiteshP/nvim-navic',
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    require('utils.init').on_attach(function(client, buffer)
      if client.supports_method('textDocument/documentSymbol') then
        require('nvim-navic').attach(client, buffer)
      end
    end)
  end,
  opts = function()
    return {
      icons = require('user.nvim-dev-icons').kinds,
      highlight = true,
    }
  end,
}
