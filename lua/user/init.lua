local M = {}

local user_modules = {
  'user.colorscheme',
  'user.mini',
  'user.files',
  'user.bufferline',
  'user.snacks',
  'user.ai',
  'user.which-key',
  'user.treesitter',
  'user.vcs',
  'user.todo-comments',
  'user.lualine',
  'user.grug-far',
  'user.autopair',
  'user.comment',
  'user.dropbar',
  'user.flash',
  'user.kulala',
  'user.neogen',
  'user.overseer',
  'user.persistence',
  'user.preview',
  'user.snippets',
  'user.textcase',
  'user.textobj',
  'user.tmux',
  'user.colorizer',
  'user.syntax',
  'user.debug',
}

function M.setup()
  for _, module in ipairs(user_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      vim.notify(string.format('Failed to load %s: %s', module, err), vim.log.levels.ERROR)
    end
  end
end

return M
