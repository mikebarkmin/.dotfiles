local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'gopls',
  cmd = { 'gopls' },
  root_dir = vim.fs.root(0, { 'go.mod', 'go.work', '.git' }),
  capabilities = capabilities,
}
