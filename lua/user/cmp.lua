local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "hrsh7th/cmp-buffer",
    },
    {
      "kola-web/cmp-path",
    },
    {
      "saadparwaiz1/cmp_luasnip",
    },
    {
      "hrsh7th/cmp-nvim-lua",
    },
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
        },
      }
    },
    { 'zbirenbaum/copilot.lua' },
    { 'zbirenbaum/copilot-cmp' },
  },
  event = {
    "InsertEnter",
  },
}

function M.config()
  local cmp = require "cmp"
  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require('copilot_cmp').setup()
  local luasnip = require "luasnip"
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = "~/.config/nvim/snippets" }

  local defaults = require("cmp.config.default")()
  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-g>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<C-e>"] = cmp.mapping(function(fallback)
        fallback()
      end),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<tab>"] = cmp.mapping.confirm { select = true },
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    sources = {
      { name = 'copilot' },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lsp_signature_help" },
    },
    window = {
      documentation = {
        max_height = 15,
        max_width = 60,
      },
    },
    formatting = {
      fields = { "abbr", "menu", "kind" },
      format = function(entry, item)
        local icons = require("icons").kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        local short_name = {
          nvim_lsp = "LSP",
          nvim_lua = "nvim",
        }

        local menu_name = short_name[entry.source.name] or entry.source.name

        item.menu = string.format("[%s]", menu_name)
        return item
      end,
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  }
end

return M
