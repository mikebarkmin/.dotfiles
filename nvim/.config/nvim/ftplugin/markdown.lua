local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'marksman',
  cmd = { 'marksman', 'server' },
  root_dir = vim.fs.root(0, { '.git', '.marksman.toml' }) or vim.fn.getcwd(),
  capabilities = capabilities,
}

-- Activate otter for embedded LSP in code blocks
-- Deferred to ensure the treesitter parser has fully parsed the buffer
vim.schedule(function()
  local ok, err = pcall(require("otter").activate, { "python", "r", "lua" }) -- adjust languages
  if not ok then
    vim.notify("otter: " .. err, vim.log.levels.WARN)
  end
end)
