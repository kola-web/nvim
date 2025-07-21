local function augroup(name)
  return vim.api.nvim_create_augroup('kola_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = true
    end
    if client and client.name == 'vtsls' then
      client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
        ---@type string, string, lsp.Range
        local action, uri, range = unpack(command.arguments)

        local function move(newf)
          client.request('workspace/executeCommand', {
            command = command.command,
            arguments = { action, uri, range, newf },
          })
        end

        local fname = vim.uri_to_fname(uri)
        ---@diagnostic disable-next-line: param-type-mismatch
        client.request('workspace/executeCommand', {
          command = 'typescript.tsserverRequest',
          arguments = {
            'getMoveToRefactoringFileSuggestions',
            {
              file = fname,
              startLine = range.start.line + 1,
              startOffset = range.start.character + 1,
              endLine = range['end'].line + 1,
              endOffset = range['end'].character + 1,
            },
          },
          ---@diagnostic disable-next-line: param-type-mismatch
        }, function(_, result)
          ---@type string[]
          local files = result.body.files
          table.insert(files, 1, 'Enter new path...')
          vim.ui.select(files, {
            prompt = 'Select move destination:',
            format_item = function(f)
              return vim.fn.fnamemodify(f, ':~:.')
            end,
          }, function(f)
            if f and f:find('^Enter new path') then
              vim.ui.input({
                prompt = 'Enter move destination:',
                default = vim.fn.fnamemodify(fname, ':h') .. '/',
                completion = 'file',
              }, function(newf)
                return newf and move(newf)
              end)
            elseif f then
              move(f)
            end
          end)
        end)
      end
    end

    local diagnostic_goto = function(next, severity)
      local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
      severity = severity and vim.diagnostic.severity[severity] or nil
      return function()
        go({ severity = severity })
      end
    end

    local keymap = vim.keymap.set
    local function createKeymap(mode, key, cmd, desc)
      keymap(mode, key, cmd, { buffer = buffer, noremap = true, silent = true, desc = desc })
    end

    createKeymap('n', 'gd', '<cmd>Trouble lsp_definitions<CR>', 'GoTo definition')
    createKeymap('n', 'grr', '<cmd>Trouble lsp_references<CR>', 'GoTo references')
    createKeymap('n', 'gri', '<cmd>Trouble lsp_implementations<CRq', 'GoTo implementation')
    createKeymap('n', 'gy', '<cmd>Trouble lsp_type_definitions<CR>', 'GoTo references')
    createKeymap('n', 'gD', '<cmd>Trouble lsp_declarations<CR>', 'GoTo declaration')
    createKeymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Float diagnostic')
    createKeymap('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
    createKeymap('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
    createKeymap('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
    createKeymap('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
    createKeymap('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
    createKeymap('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')
    createKeymap('n', ']]', function()
      Snacks.words.jump(vim.v.count1)
    end, 'Next Reference')
    createKeymap('n', '[[', function()
      Snacks.words.jump(-vim.v.count1)
    end, 'Prev Reference')
    createKeymap('n', '<leader>lI', '<cmd>LspInfo<cr>', 'lspInfo')
    createKeymap('n', '<leader>li', '<cmd>Trouble lsp_incoming_calls<cr>', 'Lsp incoming_calls')
    createKeymap('n', '<leader>lo', '<cmd>Trouble lsp_outgoing_calls<cr>', 'Lsp outgoing_calls')
    createKeymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
    createKeymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
    createKeymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Setloclist')
    createKeymap('n', '<leader>lm', '<cmd>EslintFixAll<CR>', 'EslintFixAll')
    createKeymap('n', 'gK', function()
      local new_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = new_config })
    end, 'Toggle diagnostic virtual_lines')
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'sagadiagnostc',
    'dropbar_menu',
    'lazy',
    'noice',
    'DressingSelect',
    'codecompanion',
    'DiffviewFiles',
    'grug-far',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_unlisted'),
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- 禁止新行注释
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Disable New Line Comment',
})

-- File type specific settings
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('AutoHotkeyComment', {}),
  pattern = { '*.ahk', '*.ahk2' },
  callback = function()
    vim.bo.commentstring = '; %s'
    vim.bo.comments = 's1:/*,mb:*,ex:*/,:;'
  end,
})

-- 切换session后删除所有buffer
vim.api.nvim_create_autocmd({ 'User' }, {
  group = augroup('session'),
  pattern = { 'PersistenceLoadPre' },
  callback = function()
    Snacks.bufdelete.all()
  end,
})

-- 修复cmdline windows <cr>被全局映射覆盖的问题
vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = augroup('set_default_cr'),
  callback = function()
    vim.keymap.set('n', '<cr>', '<cr>', { buffer = 0, noremap = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('set_default_cr'),
  pattern = {
    'qf',
    'vim',
  },
  callback = function(event)
    vim.keymap.set('n', '<cr>', '<cr>', { buffer = 0, noremap = true })
  end,
})
