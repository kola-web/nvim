-- WXML（微信小程序模板）filetype 设置
-- 高亮策略：用 vue parser 解析（微信双花括号 {{ }} 与 Vue 插值同源，
--   vue 的 interpolation 节点会把内部表达式注入为 javascript 高亮；
--   html parser 不识别 {{ }}，会退化为普通文本且 {{ a < b }} 边界解析错乱）。
-- 基础编辑设置继承自 html ftplugin（缩进、标签匹配、注释）。

vim.cmd('runtime! ftplugin/html.vim')

-- 用 vue parser 接管本 buffer 的 treesitter 解析与高亮
vim.treesitter.start(0, 'vue')

-- 注释语法（wxml 使用 HTML 注释）
vim.bo.commentstring = '<!-- %s -->'
