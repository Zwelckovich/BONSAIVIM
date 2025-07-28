# BONSAI Neovim Tests

This directory contains tests for the BONSAI Neovim configuration, organized by functionality.

## Test Organization

### Core Tests (in config/.config/nvim/)
- `run_tests.sh` - Core configuration tests
- `test_config.lua` - Basic configuration validation
- `test_plugins.sh` - Plugin loading tests
- `verify_plugins.lua` - Plugin verification helper

### LSP & Formatting Tests (in tests/)
- `run_lsp_tests.sh` - Comprehensive LSP and formatting test suite
- `test_lsp_conform.lua` - Detailed LSP and conform.nvim tests
- `test_lsp_setup.sh` - Basic LSP setup verification

## Running Tests

### Run all tests:
```bash
./run_all_tests.sh
```

### Run specific test suites:
```bash
# Core tests
bash config/.config/nvim/run_tests.sh

# Plugin tests
bash config/.config/nvim/test_plugins.sh

# LSP tests
bash tests/run_lsp_tests.sh
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