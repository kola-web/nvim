local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
  return
end

lspkind.init {
  preset = "codicons",
  mode = "symbol_text",
  -- symbol_map = {
  --   Codeium = "",
  --   Text = "  ",
  --   Method = "  ",
  --   Function = "  ",
  --   Constructor = "  ",
  --   Field = "  ",
  --   Variable = "  ",
  --   Class = "  ",
  --   Interface = "  ",
  --   Module = "  ",
  --   Property = "  ",
  --   Unit = "  ",
  --   Value = "  ",
  --   Enum = "  ",
  --   Keyword = "  ",
  --   Snippet = "  ",
  --   Color = "  ",
  --   File = "  ",
  --   Reference = "  ",
  --   Folder = "  ",
  --   EnumMember = "  ",
  --   Constant = "  ",
  --   Struct = "  ",
  --   Event = "  ",
  --   Operator = "  ",
  --   TypeParameter = "  ",
  -- },
}
