local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  return
end

lspsaga.setup {
  outline = {
    win_position = "left",
  },
}

local keymap = vim.keymap.set

keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>")
keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>")
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
keymap("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
