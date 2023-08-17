if not vim.g.vscode then
  require "options"
  require "keymaps"
  require "Lazy".setup("user")
  require "autocommands"
else
  require "options"
  require "Lazy".setup("vscode")
end
