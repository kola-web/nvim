local M = {
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<C-e>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  -- }

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        html = false
      }
      vim.cmd('imap <silent><script><expr> <C-e> copilot#Accept("")')
      vim.keymap.set("i", "<C-;>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-,>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)")
    end
  }
}

return M
