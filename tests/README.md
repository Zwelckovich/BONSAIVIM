# BONSAI Neovim Tests

This directory contains all tests for the BONSAI Neovim configuration, properly organized in a single location.

## Test Organization

### Test Files
- `test_config.lua` - Basic configuration validation  
- `test_config.sh` - Startup time and configuration tests
- `test_plugins.sh` - Plugin loading verification
- `test_health.sh` - Neovim health check tests
- `test_lsp_conform.lua` - Detailed LSP and conform.nvim tests
- `test_snippets.lua` - LuaSnip and nvim-cmp tests
- `test_whichkey.sh` - Which-key functionality tests
- `test_interactive.sh` - Interactive testing helper
- `test_config_load.sh` - Basic config loading test
- `test_lsp_setup.sh` - Basic LSP setup verification

### Test Runners
- `run_all_tests.sh` - Master test runner that executes all test suites
- `run_tests.sh` - Core configuration test runner
- `run_lsp_tests.sh` - Comprehensive LSP and formatting test suite
- `run_snippet_tests.sh` - Snippet functionality test runner

### Results Directory
- `results/` - Contains all test output files
  - `test_results.txt` - Core test results
  - `plugin_test_results.txt` - Plugin test results
  - `lsp_test_results.txt` - LSP test results
  - `plugin_test_output.txt` - Plugin test console output

## Running Tests

### Run all tests:
```bash
cd tests/
./run_all_tests.sh
```

### Run specific test suites:
```bash
# Core configuration tests
./run_tests.sh

# Plugin tests
./test_plugins.sh

# LSP and formatting tests
./run_lsp_tests.sh

# Snippet tests
./run_snippet_tests.sh

# Health check
./test_health.sh
```

## Test Categories

1. **Configuration Tests** - Verify basic Neovim settings and options
2. **Plugin Tests** - Ensure all plugins load correctly
3. **LSP Tests** - Verify language server functionality
4. **Formatting Tests** - Check code formatting with conform.nvim
5. **Keymap Tests** - Validate key bindings are registered
6. **Diagnostic Tests** - Ensure diagnostic settings work correctly

## Adding New Tests

When adding new functionality, create appropriate tests:

1. Add test functions to relevant `.lua` files
2. Update test runners to include new tests
3. Ensure tests are minimal and focused
4. Follow BONSAI principles - test only what's necessary