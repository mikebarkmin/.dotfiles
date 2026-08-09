-- Formatting plugin

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        tex = { 'tex-fmt', 'latexindent' },
        toml = { 'tombi' },
        dart = { 'dart_format' }
      },
      formatters = {
        dart_format = {
          command = '/home/mike/.local/flutter-sdk/flutter/bin/dart',
          args = { 'format' }
        }
      }
    },
  },
}
