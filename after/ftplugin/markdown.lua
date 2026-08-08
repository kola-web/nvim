vim.pack.add({
  'https://github.com/toppair/peek.nvim',
})

local peek = require('peek')
peek.setup({
  syntax = false,
  app = 'browser',
})

vim.api.nvim_create_user_command('PeekOpen', function()
  if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
    if vim.fn.has('macunix') then
      vim.fn.system('yabai -m space --layout bsp')
      peek.open()
      vim.fn.system('sleep 0.5 ; yabai -m space --rotate 180 ; yabai -m window --focus recent')
    else
      peek.open()
    end
  end
end, {})

vim.api.nvim_create_user_command('PeekClose', function()
  if peek.is_open() then
    if vim.fn.has('macunix') then
      peek.close()
      vim.fn.system('yabai -m space --layout stack')
    else
      peek.close()
    end
  end
end, {})

vim.keymap.set('n', '<leader>qo', ':PeekOpen<CR>', { desc = 'PeekOpen' })
vim.keymap.set('n', '<leader>qc', ':PeekClose<CR>', { desc = 'PeekClose' })

function PasteTsvToMdTable()
  local text = vim.fn.getreg('+')
  local lines = vim.split(text, '\n')
  local out = {}
  for _, line in ipairs(lines) do
    if line ~= '' then
      local row = '| ' .. string.gsub(line, '\t', ' | ') .. ' |'
      table.insert(out, row)
    end
  end
  if #out == 0 then
    return
  end
  -- 插入分隔行在第二行
  local sep_line = string.gsub(out[1], '[^|]', '-')
  table.insert(out, 2, sep_line)
  vim.api.nvim_put(out, 'l', true, true)
end

vim.keymap.set('n', '<leader>rm', PasteTsvToMdTable, { desc = 'paste CSV to markdown table' })

-- 跳转到下一个 <++> 占位符并替换
vim.keymap.set('i', ',f', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', { buffer = true, desc = 'Jump to next placeholder' })
vim.keymap.set('i', '<C-e>', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', { buffer = true, desc = 'Jump to next placeholder' })
vim.keymap.set('i', ',w', '<Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>', { buffer = true, desc = 'Jump to next placeholder (with space)' })

-- 分隔线
vim.keymap.set('i', ',n', '---<CR><CR>', { buffer = true, desc = 'Insert horizontal rule' })
vim.keymap.set('i', ',l', '--------<CR>', { buffer = true, desc = 'Insert horizontal rule (long)' })

-- 文本格式
vim.keymap.set('i', ',b', '**** <++><Esc>F*hi', { buffer = true, desc = 'Bold text' })
vim.keymap.set('i', ',s', '~~~~ <++><Esc>F~hi', { buffer = true, desc = 'Strikethrough text' })
vim.keymap.set('i', ',i', '** <++><Esc>F*i', { buffer = true, desc = 'Italic text' })
vim.keymap.set('i', ',d', '`` <++><Esc>F`i', { buffer = true, desc = 'Inline code' })

-- 代码块
vim.keymap.set('i', ',c', '```<CR><++><CR>```<CR><CR><++><Esc>4kA', { buffer = true, desc = 'Code block' })

-- 任务列表
vim.keymap.set('i', ',m', '- [ ] ', { buffer = true, desc = 'Checkbox' })

-- 链接和图片
vim.keymap.set('i', ',p', '![](<++>) <++><Esc>F[a', { buffer = true, desc = 'Image' })
vim.keymap.set('i', ',a', '[](<++>) <++><Esc>F[a', { buffer = true, desc = 'Link' })

-- 标题
vim.keymap.set('i', ',1', '# <CR><++><Esc>kA', { buffer = true, desc = 'H1 heading' })
vim.keymap.set('i', ',2', '## <CR><++><Esc>kA', { buffer = true, desc = 'H2 heading' })
vim.keymap.set('i', ',3', '### <CR><++><Esc>kA', { buffer = true, desc = 'H3 heading' })
vim.keymap.set('i', ',4', '#### <CR><++><Esc>kA', { buffer = true, desc = 'H4 heading' })
