local M = {}

M.root_patterns = { '.git', 'lua' }

M.servers = {
  'lua_ls',
  'cssls',
  'html',
  'tsserver',
  'pyright',
  'bashls',
  'jsonls',
  'yamlls',
  'emmet_language_server',
  'volar',
  'marksman',
  'phpactor',
  'docker_compose_language_service',
  'dockerls',
  'eslint',
  -- 'efm',
}

M.null_servers = {
  'prettier',
  'prettierd',
  'black',
  'stylua',
  'flake8',
  'shellcheck',
  'shfmt',
  'taplo',
  'eslint_d',
  'pint',
}

M.compare_to_clipboard = function()
  local ftype = vim.api.nvim_eval('&filetype')
  vim.cmd('vsplit')
  vim.cmd('enew')
  vim.cmd('normal! P')
  vim.cmd('setlocal buftype=nowrite')
  vim.cmd('set filetype=' .. ftype)
  vim.cmd('diffthis')
  vim.cmd([[execute "normal! \<C-w>h"]])
  vim.cmd('diffthis')
end

M.is_vue = function()
  local util = require('lspconfig.util')
  local cwd = vim.fn.getcwd()
  local project_root = util.find_node_modules_ancestor(cwd)
  local vue_path = util.path.join(project_root, 'node_modules', 'vue')
  local is_vue = vim.fn.isdirectory(vue_path) == 1
  return is_vue
end

M.flashWord = function()
  local Flash = require('flash')

  ---@param opts Flash.Format
  local function format(opts)
    -- always show first and second label
    return {
      { opts.match.label1, 'FlashMatch' },
      { opts.match.label2, 'FlashLabel' },
    }
  end

  Flash.jump({
    search = { mode = 'search' },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = function(win)
          -- limit matches to the current label
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2 -- use the second label
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
        match.label2 = labels[(m - 1) % #labels + 1]
        match.label = match.label1
      end
    end,
  })
end

return M
