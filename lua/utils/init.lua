local M = {}

M.root_patterns = { '.git', '.svn', 'lua' }

M.servers = {
  'bashls',
  'css_variables',
  'cssls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_language_server',
  'eslint',
  'html',
  'intelephense',
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'tailwindcss',
  'ts_ls',
  'volar',
  'yamlls',
  'nginx_language_server',
  -- 'jqls',
}

M.null_servers = {
  'black',
  'blade-formatter',
  'flake8',
  'js-debug-adapter',
  'prettier',
  'prettierd',
  'rustfmt',
  'shellcheck',
  'shfmt',
  'stylua',
  'taplo',
  'hadolint',
}

M.dap_servers = {
  'js',
}

M.is_win = function()
  return vim.uv.os_uname().sysname:find('Windows') ~= nil
end

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

M.is_eslint = function()
  local util = require('lspconfig.util')
  local cwd = vim.fn.getcwd()
  local project_root = util.find_node_modules_ancestor(cwd)
  local is_eslint = vim.fn.findfile('eslint.config.js', project_root) ~= '' or vim.fn.findfile('eslint.config.ts', project_root) ~= ''
  return is_eslint
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

M.closeOtherAllBuffer = function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end

M.conformFormat = function()
  local extra_lang_args = {
    javasciprt = { name = 'eslint', lsp_format = 'last' },
    typescript = { name = 'eslint', lsp_format = 'last' },
    javascriptreact = { name = 'eslint', lsp_format = 'last' },
    vue = { name = 'eslint', lsp_format = 'last' },
    json = { name = 'eslint', lsp_format = 'last' },
    jsonc = { name = 'eslint', lsp_format = 'last' },
    dockerfile = { name = 'dockerls', lsp_format = 'prefer' },
  }

  local buf = vim.api.nvim_get_current_buf()
  local extra_args = extra_lang_args[vim.bo[buf].filetype] or {}
  require('conform').format(vim.tbl_deep_extend('keep', { bufnr = buf }, extra_args))
end

M.has_value = function(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

M.get_typescript_server_path = function(root_dir)
  local util = require('lspconfig.util')
  local mason_registry = require('mason-registry')
  local global_ts = mason_registry.get_package('typescript-language-server'):get_install_path() .. '/node_modules/typescript/lib'
  -- local global_ts = mason_registry.get_package('vtsls'):get_install_path() .. '/node_modules/@vtsls/language-server/node_modules/typescript/lib'
  local found_ts = ''

  local function check_dir(path)
    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end

  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

---@param opts? {system?:boolean}
M.open = function(uri, opts)
  opts = opts or {}
  if not opts.system and M.file_exists(uri) then
    return M.float({ style = '', file = uri })
  end
  local Config = require('lazy.core.config')
  local cmd
  if not opts.system and Config.options.ui.browser then
    cmd = { Config.options.ui.browser, uri }
  elseif vim.fn.has('win32') == 1 then
    cmd = { 'explorer', uri }
  elseif vim.fn.has('macunix') == 1 then
    cmd = { 'open', uri }
  else
    if vim.fn.executable('xdg-open') == 1 then
      cmd = { 'xdg-open', uri }
    elseif vim.fn.executable('wslview') == 1 then
      cmd = { 'wslview', uri }
    else
      cmd = { 'open', uri }
    end
  end
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes('<c-G>u', true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == 'i' then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, 'n', false)
  end
end

M.get_root_dir = function()
  local cwd = vim.loop.cwd() -- 获取当前工作目录
  if cwd == nil then
    return nil
  end
  return vim.fn.fnamemodify(cwd, ':t') -- 获取目录名
end

M.scratch_open = function(fileType)
  Snacks.scratch.open({
    name = fileType,
    ft = fileType,
    win = {
      title = 'Scratch' .. fileType,
      position = 'float',
    },
  })
end

M.scratch_result = function(result)
  local filetype = vim.bo.filetype
  local icon, icon_hl = Snacks.util.icon(filetype, 'filetype')
  Snacks.win({
    title = {
      { ' ' },
      { icon .. string.rep(' ', 2 - vim.api.nvim_strwidth(icon)), icon_hl },
      { ' ' },
      { vim.bo.filetype .. ' result' },
      { ' ' },
    },
    text = result.stdout,
    width = 100,
    height = 30,
    bo = { buftype = '', buflisted = false, bufhidden = 'hide', swapfile = false },
    minimal = false,
    noautocmd = false,
    zindex = 20,
    wo = { winhighlight = 'NormalFloat:Normal' },
    border = 'rounded',
    title_pos = 'center',
    footer_pos = 'center',
  })
end

M.select_filetype = function()
  local filetypes = vim.fn.getcompletion('', 'filetype')
  Snacks.picker.select(filetypes, {
    prompt = 'filetype',
  }, function(selected)
    vim.bo.filetype = selected
  end)
end

return M
