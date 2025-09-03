local M = {}

M.root_patterns = { '.git', '.svn', 'lua' }

M.servers = {
  'bashls',
  'cssls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_language_server',
  'eslint',
  'html',
  'phpactor',
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  -- 'vtsls',
  'vue_ls',
  'vuels',
  'yamlls',
  'nginx_language_server',
  'powershell_es',
  'pylsp',
}

M.null_servers = {
  'black',
  'blade-formatter',
  'flake8',
  'hadolint',
  'isort',
  'js-debug-adapter',
  'prettier',
  'prettierd',
  'rustfmt',
  'shellcheck',
  'shfmt',
  'stylua',
  'taplo',
  'copilot-language-server',
  'php-cs-fixer'
  -- 'kulala-fmt',
}

M.kind_filter = {
  default = {
    'Class',
    'Constructor',
    'Enum',
    'Field',
    'Function',
    'Interface',
    'Method',
    'Module',
    'Namespace',
    'Package',
    'Property',
    'Struct',
    'Trait',
  },
  markdown = false,
  help = false,
  -- you can specify a different filter for each filetype
  lua = {
    'Class',
    'Constructor',
    'Enum',
    'Field',
    'Function',
    'Interface',
    'Method',
    'Module',
    'Namespace',
    -- "Package", -- remove package since luals uses it for control flow structures
    'Property',
    'Struct',
    'Trait',
  },
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

local function add_fold(match)
  vim.api.nvim_win_call(match.win, function()
    local fold = vim.fn.foldclosed(match.pos[1])
    match.fold = fold ~= -1 and fold or nil
  end)
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
    ps1 = { name = 'powershell_es', lsp_format = 'prefer' },
    http = { name = 'kulala', lsp_format = 'prefer' },
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
  local global_ts = vim.fn.expand('$MASON/packages') .. '/typescript-language-server' .. '/node_modules/typescript/lib'
  local found_ts = ''

  local function check_dir(path)
    found_ts = table.concat({ path, 'node_modules', 'typescript', 'lib' })
    if vim.uv.fs_stat(found_ts) then
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
    zindex = 100,
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
    if selected then
      vim.bo.filetype = selected
    end
  end)
end

M.add_to_gitignore = function()
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.path
  local projectRoot = vim.fn.getcwd()
  local relativePath = currentPath:sub(#projectRoot + 2):gsub('[\r\n]+$', '') -- 去除末尾换行符
  local gitignorePath = projectRoot .. '/.gitignore'

  -- 打开或创建 .gitignore 文件
  local gitignoreFile = io.open(gitignorePath, 'a+')
  if not gitignoreFile then
    print('无法打开或创建 .gitignore 文件')
    return
  end

  -- 检查文件路径是否已经存在
  local exists = false
  for line in gitignoreFile:lines() do
    if line == relativePath then
      exists = true
      break
    end
  end

  -- 如果不存在，则追加路径
  if not exists then
    gitignoreFile:write(relativePath .. '\n')
    print('已将 ' .. relativePath .. ' 添加到 .gitignore')
  else
    print(relativePath .. ' 已存在于 .gitignore 中')
  end

  gitignoreFile:close()

  -- 使用 Git 删除文件
  local deleteCommand = 'git rm --cached ' .. vim.fn.shellescape(relativePath)
  local result = os.execute(deleteCommand)
  if result == 0 then
    print('已使用 Git 删除 ' .. relativePath)
  else
    print('无法使用 Git 删除 ' .. relativePath)
  end
end

M.copy_file_path = function()
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.path

  -- 检查当前操作系统并使用相应的命令复制到剪贴板
  if vim.fn.has('mac') == 1 then
    os.execute('echo "' .. currentPath .. '" | pbcopy')
  elseif vim.fn.has('unix') == 1 then
    os.execute('echo "' .. currentPath .. '" | xclip -selection clipboard')
  elseif vim.fn.has('win32') == 1 then
    os.execute('echo ' .. currentPath .. ' | clip')
  else
    print('Unsupported OS')
  end
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

M.is_vue2_project = function()
  local package_json_path = vim.fn.getcwd() .. '/package.json'
  local file = io.open(package_json_path, 'r')
  if not file then
    return false -- If no package.json exists, assume it's not a Vue 2 project.
  end

  local content = file:read('*a')
  file:close()

  -- Search for the "vue" key in dependencies with a version starting with "2"
  local vue_version = content:match('"vue"%s*:%s*"(%^?2[%d%.]*)"')
  if vue_version then
    return true
  end
  return false
end

M.find_latest_volta_node = function()
  if vim.fn.has('win32') == 1 then
    return vim.fn.getenv('LOCALAPPDATA') .. '/Volta/tools/image/node/22.16.0/node.exe'
  else
    return 'node'
  end
end

return M
