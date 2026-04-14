local lualine_ok, lualine = pcall(require, 'lualine')
if lualine_ok then
  local icons = require('utils.icons')

  local opts = {
    options = {
      theme = 'auto',
      globalstatus = true,
      disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        {
          'diagnostics',
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        {
          'diff',
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
        },
      },
      lualine_c = {
        {
          function()
            return require('utils').get_root_dir()
          end,
          icon = '',
        },
      },
      lualine_x = {
        {
          function()
            return vim.g.aiStatus
          end,
          icon = icons.ai.Ai,
          cond = function()
            return vim.g.aiStatus ~= nil
          end,
        },
        'overseer',
        'lsp_status',
        'filetype',
        'filesize',
        {
          'fileformat',
          symbols = {
            unix = 'Unix (LF)',
            dos = 'Windows (CRLF)',
            mac = 'Unix (LF)',
          },
        },
      },
      lualine_y = {
        'progress',
      },
      lualine_z = {
        'location',
      },
    },
    extensions = { 'lazy', 'mason', 'man' },
  }

  lualine.setup(opts)
end
