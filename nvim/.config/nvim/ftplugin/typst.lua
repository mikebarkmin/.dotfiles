local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'tinymist',
  cmd = { 'tinymist' },
  root_dir = vim.fs.root(0, { '.git' }) or vim.fn.getcwd(),
  capabilities = capabilities,
  settings = {
    formatterMode = 'typstyle',
  },
}
