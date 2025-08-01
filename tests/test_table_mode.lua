-- Basic table-mode plugin test
print("=== Testing Table-Mode Plugin ===")
print("")

-- Test 1: Module loading
print("Test 1: Loading vim-table-mode...")
local ok, err = pcall(function()
	-- Force load the plugin since it's lazy loaded
	local lazy = require("lazy")
	lazy.load({ plugins = { "vim-table-mode" } })
	vim.wait(1000)
end)

if ok then
	print("✓ Plugin loaded successfully")
else
	print("✗ Plugin failed to load: " .. tostring(err))
end

-- Test 2: Command existence
print("")
print("Test 2: Checking commands...")
local commands = {
	"TableModeToggle",
	"Tableize",
	"TableModeDeleteRow",
	"TableModeDeleteColumn",
	"TableModeInsertColumn",
	"TableModeInsertRow",
}

local cmd_ok = 0
local cmd_fail = 0

for _, cmd in ipairs(commands) do
	if vim.fn.exists(":" .. cmd) == 2 then
		print("  ✓ " .. cmd .. " command exists")
		cmd_ok = cmd_ok + 1
	else
		print("  ✗ " .. cmd .. " command not found")
		cmd_fail = cmd_fail + 1
	end
end

-- Test 3: Configuration variables
print("")
print("Test 3: Checking configuration...")
local configs = {
	{ name = "table_mode_corner", expected = "|" },
	{ name = "table_mode_corner_corner", expected = "+" },
	{ name = "table_mode_header_fillchar", expected = "-" },
	{ name = "table_mode_auto_align", expected = 1 },
	{ name = "table_mode_delimiter", expected = "," },
}

local config_ok = 0
local config_fail = 0

for _, config in ipairs(configs) do
	local value = vim.g[config.name]
	if value == config.expected then
		print("  ✓ " .. config.name .. " = " .. tostring(value))
		config_ok = config_ok + 1
	else
		print("  ✗ " .. config.name .. " = " .. tostring(value) .. " (expected: " .. tostring(config.expected) .. ")")
		config_fail = config_fail + 1
	end
end

-- Test 4: Navigation mappings
print("")
print("Test 4: Checking navigation mappings...")
local nav_mappings = {
	{ name = "table_mode_motion_up_map", expected = "[t" },
	{ name = "table_mode_motion_down_map", expected = "]t" },
	{ name = "table_mode_motion_left_map", expected = "[T" },
	{ name = "table_mode_motion_right_map", expected = "]T" },
}

local nav_ok = 0
local nav_fail = 0

for _, mapping in ipairs(nav_mappings) do
	local value = vim.g[mapping.name]
	if value == mapping.expected then
		print("  ✓ " .. mapping.name .. " = " .. tostring(value))
		nav_ok = nav_ok + 1
	else
		print(
			"  ✗ " .. mapping.name .. " = " .. tostring(value) .. " (expected: " .. tostring(mapping.expected) .. ")"
		)
		nav_fail = nav_fail + 1
	end
end

-- Test 5: Text objects
print("")
print("Test 5: Checking text objects...")
local text_objects = {
	{ name = "table_mode_cell_text_object_a_map", expected = "atc" },
	{ name = "table_mode_cell_text_object_i_map", expected = "itc" },
}

local obj_ok = 0
local obj_fail = 0

for _, obj in ipairs(text_objects) do
	local value = vim.g[obj.name]
	if value == obj.expected then
		print("  ✓ " .. obj.name .. " = " .. tostring(value))
		obj_ok = obj_ok + 1
	else
		print("  ✗ " .. obj.name .. " = " .. tostring(value) .. " (expected: " .. tostring(obj.expected) .. ")")
		obj_fail = obj_fail + 1
	end
end

-- Test 6: Highlight groups
print("")
print("Test 6: Checking highlight groups...")
local highlights = {
	"TableModeBorder",
	"TableModeHeader",
	"TableModeSeparator",
}

local hl_ok = 0
local hl_fail = 0

for _, hl in ipairs(highlights) do
	local hl_info = vim.api.nvim_get_hl(0, { name = hl })
	if hl_info and hl_info.fg then
		print("  ✓ " .. hl .. " highlight exists with fg color")
		hl_ok = hl_ok + 1
	else
		print("  ✗ " .. hl .. " highlight not properly set")
		hl_fail = hl_fail + 1
	end
end

-- Summary
print("")
print("=== Summary ===")
print("Commands: " .. cmd_ok .. "/" .. #commands .. " passed")
print("Configs: " .. config_ok .. "/" .. #configs .. " passed")
print("Navigation: " .. nav_ok .. "/" .. #nav_mappings .. " passed")
print("Text objects: " .. obj_ok .. "/" .. #text_objects .. " passed")
print("Highlights: " .. hl_ok .. "/" .. #highlights .. " passed")

local total_tests = 1 + #commands + #configs + #nav_mappings + #text_objects + #highlights
local passed_tests = (ok and 1 or 0) + cmd_ok + config_ok + nav_ok + obj_ok + hl_ok
print("")
print("Total: " .. passed_tests .. "/" .. total_tests .. " tests passed")

-- Exit with appropriate code
if passed_tests == total_tests then
	print("")
	print("✓ All table-mode tests passed!")
	vim.cmd("qa!")
else
	print("")
	print("✗ Some table-mode tests failed")
	vim.cmd("cq")
end
