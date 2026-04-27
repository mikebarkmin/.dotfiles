local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'opescad-lsp',
  cmd = { 'openscad-lsp', '--stdio' },
  root_dir = vim.fs.root(0, { '.git' }) or vim.fn.getcwd(),
  single_file_support = true,
  capabilities = capabilities,
}

