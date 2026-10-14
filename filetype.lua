vim.filetype.add({
  -- 扩展名
  extension = {
    pn = 'potion',
    wxml = 'wxml', -- 独立 filetype：ftplugin 用 vue parser 高亮 {{ }}，html LSP 单独 attach（见 after/lsp/html.lua）
    wxss = 'css',
    wxs = 'javascript',
    wpy = 'vue',
    ['code-snippets'] = 'jsonc', -- Included in the plugin
    template = 'nginx',
    ['code-profile'] = 'json',
    ['http'] = 'http',
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
    ['~/.config/kitty/*.conf'] = 'kitty',
    ['.*%.blade%.php'] = 'blade',
  },
})
