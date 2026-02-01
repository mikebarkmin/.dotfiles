local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'pyright',
  cmd = { 'pyright-langserver', '--stdio' },
  root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }),
  capabilities = capabilities,
}
