local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

-- texlab for LaTeX features
vim.lsp.start {
  name = 'texlab',
  cmd = { 'texlab' },
  root_dir = vim.fs.root(0, { '.latexmkrc', '.git' }) or vim.fn.getcwd(),
  capabilities = capabilities,
}

-- ltex_plus for grammar checking (shared with markdown)
local root = vim.fs.root(0, { '.git', '.vscode' })
local ltex_config = {
  name = 'ltex_plus',
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
