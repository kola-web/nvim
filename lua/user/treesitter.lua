local parsers = {
  'bash',
  'blade',
  'css',
  'dart',
  'diff',
  'dockerfile',
  'fish',
  'gitignore',
  'html',
  'http',
  'javascript',
  'jq',
  'jsdoc',
  'json',
  'json5',
  'kdl',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'php',
  'powershell',
  'python',
  'regex',
  'ron',
  'rust',
  'scss',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
  'ini',
}

local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter')
if treesitter_ok then
  treesitter.install(parsers)

  local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then
      return
    end
    vim.treesitter.start(buf, language)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  local available_parsers = treesitter.get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      local installed_parsers = treesitter.get_installed('parsers')

      if vim.tbl_contains(installed_parsers, language) then
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        treesitter.install(language):await(function()
          treesitter_try_attach(buf, language)
        end)
      else
        treesitter_try_attach(buf, language)
      end
    end,
  })
end
