local M = {}
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

M.setup = function()
  require('lazy').setup({
    spec = {
      { import = 'vscodeNeovim' },
      { import = 'user' },
      { import = 'user.preview' },
      { import = 'lsp' },
    },
    defaults = {
      -- 默认延迟加载所有插件，提升启动性能
      lazy = true,
      -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      -- have outdated releases, which may break your Neovim install.
      version = false, -- always use the latest git commit
      -- version = "*", -- try installing the latest stable version for plugins that support semver
      cond = not vim.g.vscode,
    },
    dev = {
      path = '~/.config/nvim-plugins',
      patterns = { 'kola-web' },
      fallback = true,
    },
    install = { colorscheme = { 'tokyodark' } },
    checker = { enabled = true, notify = false }, -- automatically check for plugin updates
    change_detection = {
      enabled = true,
      notify = false,
    },
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          'gzip',
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  })
end

return M
