local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "bash",
    "dart",
    "diff",
    "dockerfile",
    "fish",
    "gitignore",
    "html",
    "javascript",
    "css",
    "scss",
    "jq",
    "json",
    "json5",
    "jsdoc",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "php",
    "phpdoc",
    "tsx",
    "vim",
    "vue",
    "toml",
    "typescript",
    "tsx",
    "yaml",
  },
  sync_install = false,
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable_virtual_text = true,
  },
  indent = { enable = true, disable = { "python", "css", "rust" } },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
