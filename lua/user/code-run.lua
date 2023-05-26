local M = {
  "CRAG666/code_runner.nvim",
  event = "VeryLazy"
}

M.opts = {
  filetype = {
    typescript = "deno run",
    javascript = "node",
  },
}

return M
