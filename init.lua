if not vim.g.vscode then
  require "options"
  require "keymaps"
  require "Lazy"
  require "autocommands"
else
  require "options"
end

