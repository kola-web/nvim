if vim.g.vscode then
  require "options"
  require "Lazy".setup("vscode")
else
  require "options"
  require "keymaps"
  require "Lazy".setup("user")
  require "autocommands"
end
