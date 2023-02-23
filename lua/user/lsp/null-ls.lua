local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier,

    formatting.stylua,

    formatting.shfmt,
    code_actions.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },
    diagnostics.editorconfig_checker,
  },
}
