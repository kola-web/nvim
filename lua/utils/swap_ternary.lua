-- 交换三元表达式：cond ? A : B → cond ? B : A
-- 用法：光标置于三元表达式上，触发 <leader>rT
local ts = require('vim.treesitter')
local get_node_text = ts.get_node_text
local M = {}
-- javascript 用 conditional_expression，typescript 用 ternary_expression
local TERNARY_TYPES = { 'conditional_expression', 'ternary_expression' }

local function get_ternary_node(node)
	if not node then
		return
	end
	if not vim.tbl_contains(TERNARY_TYPES, node:type()) then
		node = node:parent()
		return get_ternary_node(node)
	end
	return node
end

function M.swap_ternary()
	local bufnr = vim.api.nvim_get_current_buf()
	if not pcall(vim.treesitter.get_parser, bufnr) then
		print("No treesitter parser for current language")
		return
	end
	-- 预热：确保语法树已生成（从未解析过的 buffer 直接 get_node 会拿不到节点）
	local ok_pre, err_pre = pcall(function()
		vim.treesitter.get_parser(bufnr):parse()
	end)
	if not ok_pre then
		print("Treesitter parse failed: " .. tostring(err_pre))
		return
	end
	local node = ts.get_node({ bufnr = bufnr, ignore_injections = false })
	local ternary_node = get_ternary_node(node)
	if not ternary_node then
		print("No ternary expression found")
		return
	end
	local t_consequence = ternary_node:field("consequence")
	local result = ""
	local t_alternate = ternary_node:field("alternative")
	for i = 1, #t_alternate do
		local text = get_node_text(t_alternate[i], bufnr)
		result = result .. text
	end
	result = result .. " : "
	for i = 1, #t_consequence do
		local text = get_node_text(t_consequence[i], bufnr)
		result = result .. text
	end
	local t = {}
	local lines = string.gmatch(result, "[^\r\n]+")
	for line in lines do
		table.insert(t, line)
	end
	-- replace the ternary with the swapped text
	local start_row, start_col = t_consequence[1]:start()
	local end_row, end_col = t_alternate[#t_alternate]:end_()
	vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, t)
end

return M
