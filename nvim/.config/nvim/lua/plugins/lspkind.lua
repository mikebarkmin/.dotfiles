require('lspkind').init({
    mode = 'symbol_text',

    -- enables text annotations (default: 'default')
    -- default symbol map can be either 'default' or 'codicons' for codicon preset (requires vscode-codicons font installed)
    preset = 'codicons',

    -- override preset symbols (default: {})
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})
