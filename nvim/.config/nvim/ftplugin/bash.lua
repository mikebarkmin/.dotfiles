local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'bashls',
  cmd = { 'bash-language-server', 'start' },
  root_dir = vim.fs.root(0, { '.git' }),
  capabilities = capabilities,
  filetypes = { 'bash' },
}
