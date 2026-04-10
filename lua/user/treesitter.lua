local M = {
  { -- 高亮、编辑和导航代码
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ 配置 Treesitter ]] 参见 `:help nvim-treesitter-intro`
    config = function()
      -- 确保基本解析器已安装
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
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- 检查解析器是否存在并加载它
        if not vim.treesitter.language.add(language) then
          return
        end
        -- 启用语法高亮和其他 Treesitter 功能
        vim.treesitter.start(buf, language)

        -- 启用基于 Treesitter 的折叠
        -- 有关折叠的更多信息，参见 `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- 启用基于 Treesitter 的缩进
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require('nvim-treesitter').get_installed('parsers')

          if vim.tbl_contains(installed_parsers, language) then
            -- 如果解析器已安装，则启用它
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- 如果 `nvim-treesitter` 中有可用的解析器，则自动安装，并在安装完成后启用它
            require('nvim-treesitter').install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            -- 尝试启用 Treesitter 功能，以防解析器存在但无法从 `nvim-treesitter` 获取
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}

return M
