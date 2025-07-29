-- Comprehensive test suite for Phase 10: nvim-spectre
print("=== Phase 10: nvim-spectre Test Suite ===\n")

local passed = 0
local failed = 0

-- Test 1: Plugin file exists
local function test_plugin_exists()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local f = io.open(plugin_path, "r")
	if f then
		f:close()
		print("✓ Test 1: Plugin file exists")
		return true
	else
		print("✗ Test 1: Plugin file not found")
		return false
	end
end

-- Test 2: Plugin configuration is valid Lua
local function test_plugin_valid()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local ok, result = pcall(dofile, plugin_path)
	if ok and type(result) == "table" then
		print("✓ Test 2: Plugin configuration is valid")
		return true
	else
		print("✗ Test 2: Plugin configuration is invalid: " .. tostring(result))
		return false
	end
end

-- Test 3: Required plugin fields exist
local function test_required_fields()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local ok, plugin = pcall(dofile, plugin_path)
	if not ok then
		print("✗ Test 3: Could not load plugin")
		return false
	end

	local required = { [1] = "nvim-pack/nvim-spectre", keys = true, dependencies = true, config = true }
	local all_found = true

	for field, expected in pairs(required) do
		if type(field) == "number" then
			if plugin[field] ~= expected then
				print("✗ Test 3: Missing or incorrect plugin name")
				all_found = false
			end
		else
			if not plugin[field] then
				print("✗ Test 3: Missing required field: " .. field)
				all_found = false
			end
		end
	end

	if all_found then
		print("✓ Test 3: All required fields present")
	end
	return all_found
end

-- Test 4: Keymaps are properly defined
local function test_keymaps()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local ok, plugin = pcall(dofile, plugin_path)
	if not ok or not plugin.keys then
		print("✗ Test 4: Could not access keymaps")
		return false
	end

	local expected_keys = {
		["<leader>ss"] = "Search (Spectre)",
		["<leader>sw"] = "Search word (Spectre)",
		["<leader>sp"] = "Search in file (Spectre)",
		["<leader>sr"] = "Search and replace (Spectre)",
	}

	local found_keys = {}
	for _, keymap in ipairs(plugin.keys) do
		if type(keymap) == "table" and keymap[1] then
			found_keys[keymap[1]] = true
		end
	end

	local all_found = true
	for key, desc in pairs(expected_keys) do
		if not found_keys[key] then
			print("✗ Test 4: Missing keymap: " .. key .. " (" .. desc .. ")")
			all_found = false
		end
	end

	if all_found then
		print("✓ Test 4: All expected keymaps defined (" .. #plugin.keys .. " total)")
	end
	return all_found
end

-- Test 5: BONSAI colors are defined
local function test_bonsai_colors()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local content = ""
	local f = io.open(plugin_path, "r")
	if f then
		content = f:read("*all")
		f:close()
	end

	local has_colors = content:match("local colors = {") ~= nil
	local has_highlights = content:match("SpectreSearch") ~= nil

	if has_colors and has_highlights then
		print("✓ Test 5: BONSAI colors properly configured")
		return true
	else
		print("✗ Test 5: BONSAI colors not properly configured")
		return false
	end
end

-- Test 6: Dependencies are correct
local function test_dependencies()
	local plugin_path = "/home/zwelch/projects/BONSAIVIM/config/.config/nvim/lua/plugins/spectre.lua"
	local ok, plugin = pcall(dofile, plugin_path)
	if not ok or not plugin.dependencies then
		print("✗ Test 6: Could not check dependencies")
		return false
	end

	local has_plenary = false
	for _, dep in ipairs(plugin.dependencies) do
		if dep == "nvim-lua/plenary.nvim" then
			has_plenary = true
			break
		end
	end

	if has_plenary then
		print("✓ Test 6: Required dependencies configured")
		return true
	else
		print("✗ Test 6: Missing plenary.nvim dependency")
		return false
	end
end

-- Run all tests
if test_plugin_exists() then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin_valid() then
	passed = passed + 1
else
	failed = failed + 1
end
if test_required_fields() then
	passed = passed + 1
else
	failed = failed + 1
end
if test_keymaps() then
	passed = passed + 1
else
	failed = failed + 1
end
if test_bonsai_colors() then
	passed = passed + 1
else
	failed = failed + 1
end
if test_dependencies() then
	passed = passed + 1
else
	failed = failed + 1
end

-- Summary
print("\n=== Test Summary ===")
print("Passed: " .. passed .. "/6")
print("Failed: " .. failed .. "/6")

if failed == 0 then
	print("\n✅ All Phase 10 tests passed!")
else
	print("\n❌ Some tests failed!")
	os.exit(1)
end
