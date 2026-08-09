local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'dart',
  cmd = { '/home/mike/.local/flutter-sdk/flutter/bin/dart', 'language-server' },
  root_dir = vim.fs.root(0, { 'pubspec.yaml', '.git' }),
  capabilities = capabilities,
}
