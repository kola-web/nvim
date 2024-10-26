vim.g.mini_component = function(state)
  local fs_actions = require('neo-tree.sources.filesystem.lib.fs_actions')
  local node = state.tree:get_node()
  local currentPath = node.id
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
  local currentPath = node.id
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
