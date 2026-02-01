local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'hyprls',
  cmd = { 'hyprls' },
  root_dir = vim.fn.getcwd(),
  capabilities = capabilities,
}
