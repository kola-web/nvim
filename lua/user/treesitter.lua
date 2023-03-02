local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  ensure_installed = 'all',
  sync_install = false,
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable_virtual_text = true,
  },
  indent = { enable = true, disable = { 'python', 'css', 'rust' } },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { 'markdown' },
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
