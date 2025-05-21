vim.g.mini_component = function(state)
  local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
  local node = state.tree:get_node()
  local currentPath = node.type == 'file' and node._parent_id or node.id
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlComponent',
    currentPath,
  })
  fs_actions.rename_node(currentPath .. '/wxmlComponent', function(_, path)
    vim.cmd('edit ' .. path .. '/index.wxml')
  end)
end

vim.g.mini_page = function(state)
  local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
  local node = state.tree:get_node()
  local currentPath = node.type == 'file' and node._parent_id or node.id
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlPage',
    currentPath,
  })
  fs_actions.rename_node(currentPath .. '/wxmlPage', function(_, path)
    vim.cmd('edit ' .. path .. '/index.wxml')
  end)
end

vim.g.mini_file_mini_component = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlComponent',
    currentPath,
  })
  MiniFiles.synchronize()
  vim.fn.search('wxmlComponent', 'w') -- 'w' 标志表示包裹搜索（wrap around）
end

vim.g.mini_file_mini_page = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlPage',
    currentPath,
  })
  MiniFiles.synchronize()
  vim.fn.search('wxmlComponent', 'w') -- 'w' 标志表示包裹搜索（wrap around）
end
