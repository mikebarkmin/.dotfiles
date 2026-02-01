local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'cssls',
  cmd = { 'vscode-css-language-server', '--stdio' },
  root_dir = vim.fs.root(0, { 'package.json', '.git' }) or vim.fn.getcwd(),
  capabilities = capabilities,
}
