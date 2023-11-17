vim.filetype.add({
  -- 扩展名
  extension = {
    pn = 'potion',
    wxml = 'html',
    wxss = 'css',
    wxs = 'javascript',
    ['code-snippets'] = 'jsonc', -- Included in the plugin
    conf = 'dosini',
    template = 'nginx',
  },
  -- 文件名
  filename = {
    hosts = 'sh',
    zpreztorc = 'sh',
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    ['.*git/config'] = 'gitconfig', -- Included in the plugin
    ['nginx/*.conf'] = 'nginx', -- Included in the plugin
    ['nginx/templates/*'] = 'nginx', -- Included in the plugin
    ['vscode-snippets'] = 'jsonc', -- Included in the plugin
  },
})
