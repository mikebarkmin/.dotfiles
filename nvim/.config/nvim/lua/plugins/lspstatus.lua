require('lsp-status').status()
require('lsp-status').register_progress()
require('lsp-status').config({
    indicator_errors = '✗',
    indicator_warnings = '⚠',
    indicator_info = '',
    indicator_hint = '',
    indicator_ok = '✔',
    current_function = true,
    update_interval = 100,
    status_symbol = ' 🇻',
})
