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

-- Wrap prose at 80 columns with gq.
-- tinymist advertises rangeFormatting, so nvim sets formatexpr to the LSP one
-- and gq gets routed to typstyle, which never reflows text. Clear it on attach
-- to get Vim's internal formatter back; vim.lsp.buf.format() still uses typstyle.
vim.opt_local.textwidth = 80
vim.api.nvim_create_autocmd('LspAttach', {
  buffer = 0,
  callback = function(args)
    if vim.lsp.get_client_by_id(args.data.client_id).name == 'tinymist' then
      -- deferred: nvim sets formatexpr after LspAttach fires
      vim.schedule(function()
        vim.bo[args.buf].formatexpr = ''
      end)
    end
  end,
})
