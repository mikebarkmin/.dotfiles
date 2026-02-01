local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

-- ltex_plus for grammar checking
local root = vim.fs.root(0, { '.git', '.vscode' })
local ltex_config = {
  name = 'ltex',
  cmd = { 'ltex-ls' },
  root_dir = root,
  capabilities = capabilities,
  settings = {
    ltex = {
      language = 'de-DE',
      diagnosticSeverity = 'information',
    },
  },
}

-- Try to read .vscode/settings.json
if root then
  local vscode_settings = root .. '/.vscode/settings.json'
  if vim.fn.filereadable(vscode_settings) == 1 then
    local ok, settings = pcall(function()
      local content = vim.fn.readfile(vscode_settings)
      return vim.fn.json_decode(table.concat(content, '\n'))
    end)
    if ok and settings['ltex.language'] then
      ltex_config.settings.ltex.language = settings['ltex.language']
    end
  end
end

vim.lsp.start(ltex_config)

-- marksman for markdown navigation/references
vim.lsp.start {
  name = 'marksman',
  cmd = { 'marksman', 'server' },
  root_dir = vim.fs.root(0, { '.git', '.marksman.toml' }) or vim.fn.getcwd(),
  capabilities = capabilities,
}

-- Activate otter for embedded LSP in code blocks
require('otter').activate()
