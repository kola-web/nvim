local M = {
  "neoclide/coc.nvim",
  branch = "release",
  lazy = false,
}

vim.g["coc_global_extensions"] = {
  "coc-diagnostic",
  "coc-html",
  "coc-css",
  "coc-tsserver",
  "coc-eslint",
  "coc-prettier",
  "@yaegassy/coc-volar",
  "@yaegassy/coc-volar-tools",
  "coc-markdownlint",
  "coc-yaml",
  "coc-sumneko-lua",
  "coc-snippets"
}

M.config = function()
  local keyset = vim.keymap.set
  -- Autocomplete
  function _G.check_back_space()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
  end

  -- Use Tab for trigger completion with characters ahead and navigate
  -- NOTE: There's always a completion item selected by default, you may want to enable
  -- no select by setting `"suggest.noselect": true` in your configuration file
  -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
  -- other plugins before putting this into your config
  local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
  keyset("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
  keyset("i", "<C-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
  keyset("i", "<Tab>", [[coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<Tab>"]], opts)

  -- GoTo code navigation
  keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
  keyset("n", "gD", "<Plug>(coc-type-definition)", { silent = true })
  keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
  keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

  -- Use K to show documentation in preview window
  function _G.show_docs()
    local cw = vim.fn.expand "<cword>"
    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
      vim.api.nvim_command("h " .. cw)
    elseif vim.api.nvim_eval "coc#rpc#ready()" then
      vim.fn.CocActionAsync "doHover"
    else
      vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
  end

  keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

  -- Map function and class text objects
  -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
  keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
  keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
  keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
  keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
  keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
  keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
  keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
  keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

  -- Remap <C-f> and <C-b> to scroll float windows/popups
  ---@diagnostic disable-next-line: redefined-local
  local opts = { silent = true, nowait = true, expr = true }
  keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
  keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
  keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
  keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
end

return M
