local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'lua_ls',
  cmd = { 'lua-language-server' },
  root_dir = vim.fs.root(0, { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' }),
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
