local M = {
  'LunarVim/bigfile.nvim',
  lazy = false,
  opts = function()
    local cmp = {
      name = 'cmp',
      opts = { defer = true },
      disable = function()
        local ok, cmp = pcall(require, 'cmp')
        if ok then
          cmp.setup.buffer({ enabled = false })
        end
      end,
    }

    return {
      filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = { -- features to disable
        'lsp',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
        'filetype',
        cmp,
      },
    }
  end,
}

return M
