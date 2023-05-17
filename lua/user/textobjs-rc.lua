local keymap = vim.keymap.set
local status_ok, variousTextobjs = pcall(require, "various-textobjs")
if not status_ok then
  return
end

variousTextobjs.setup {
  -- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
  -- set to 0 to only look in the current line
  lookForwardSmall = 5,

  -- lines to seek forwards for "big" textobjs (linewise textobjs & url textobj)
  lookForwardBig = 15,

  -- use suggested keymaps (see README)
  useDefaultKeymaps = false,
}

keymap({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
keymap({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

keymap({ "o", "x" }, "ae", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

keymap({ "o", "x" }, "ax", "<cmd>lua require('various-textobjs').htmlAttribute(true)<CR>")
keymap({ "o", "x" }, "ix", "<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>")
