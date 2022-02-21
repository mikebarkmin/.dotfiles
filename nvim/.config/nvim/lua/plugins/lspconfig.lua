-- options for lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    update_in_insert = true,
    virtual_text = {
        true,
        spacing = 6,
        --severity_limit='Error'  -- Only show virtual text on error
    },
  }
)

require('lspconfig').texlab.setup {
  settings = {
    texlab = {
      auxDirectory = "build/pdf",
      rootDirectory = ".",
      chktex = {
        onEdit = true
      },
      build = {
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = true
      }
    }
  }
}

require("lspconfig").ltex.setup({
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown", "text", "txt" },
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "de",
			},
			trace = { server = "verbose" },
			dictionary = {},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})

-- se LSP diagnostic symbols/signs
vim.api.nvim_command [[ sign define LspDiagnosticsSignError         text=✗ texthl=LspDiagnosticsSignError       linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignWarning       text=⚠ texthl=LspDiagnosticsSignWarning     linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignInformation   text= texthl=LspDiagnosticsSignInformation linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignHint          text= texthl=LspDiagnosticsSignHint        linehl= numhl= ]]
