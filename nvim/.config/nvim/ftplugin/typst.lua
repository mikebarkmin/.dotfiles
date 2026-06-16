local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.keymap.set('n', '<leader>ao', function()
  local file = vim.fn.expand('%:p')
  vim.cmd('split | terminal typst watch ' .. file .. ' --open')
end, { buffer = true, desc = 'Typst watch and open' })

vim.lsp.start {
  name = 'tinymist',
  cmd = { 'tinymist' },
  root_dir = vim.fs.root(0, { '.git' }) or vim.fn.getcwd(),
  capabilities = capabilities,
  settings = {
    formatterMode = 'typstyle',
  },
}
