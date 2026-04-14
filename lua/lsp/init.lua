local M = {}

local lsp_modules = {
  'lsp.lsp',
  'lsp.blink',
  'lsp.conform',
  'lsp.emmet',
}

function M.setup()
  for _, module in ipairs(lsp_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      vim.notify(string.format('Failed to load %s: %s', module, err), vim.log.levels.ERROR)
    end
  end
end

return M
