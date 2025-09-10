-- Test LuaSnip snippet plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, luasnip = pcall(require, "luasnip")
if not ok then
	print("✗ Failed to require luasnip module")
	vim.cmd("cq")
	return
end

-- Test variables
local tests_passed = 0
local tests_failed = 0

local function test(name, condition)
	if condition then
		print("✓ " .. name)
		tests_passed = tests_passed + 1
	else
		print("✗ " .. name)
		tests_failed = tests_failed + 1
	end
end

-- Test luasnip functions
test("LuaSnip has expand function", type(luasnip.expand) == "function")
test("LuaSnip has expand_or_jump function", type(luasnip.expand_or_jump) == "function")
test("LuaSnip has jump function", type(luasnip.jump) == "function")
test("LuaSnip has jumpable function", type(luasnip.jumpable) == "function")
test("LuaSnip has setup function", type(luasnip.setup) == "function")

-- Test snippet creation
test("LuaSnip has snippet constructor", type(luasnip.snippet) == "function")
test("LuaSnip has text_node constructor", type(luasnip.text_node) == "function")
test("LuaSnip has insert_node constructor", type(luasnip.insert_node) == "function")

-- Test luasnip is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "LuaSnip" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("LuaSnip plugin has config function", config_exists)

-- Test friendly snippets loader
local loader_ok = pcall(require, "luasnip.loaders.from_vscode")
test("VSCode snippet loader available", loader_ok)

-- Summary
print("\n=== LuaSnip Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
