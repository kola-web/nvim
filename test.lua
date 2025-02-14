-- 示例字符串，包含 HTML、Vue 或 JSX 中的属性
local str = [[
    <div id="app" class="container" :prop="value" @click="handler" v-if="condition" name={name} #name>
]]

-- 正则表达式，匹配所有可能的属性形式
local pattern = [[([:@]?[%w-]+)=['"]?([^'">]*)['"]?]]

-- 用 gmatch 遍历所有匹配的属性
for attr, value in string.gmatch(str, pattern) do
    print(value)
end

