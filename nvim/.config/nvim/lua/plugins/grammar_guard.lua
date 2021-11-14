-- setup LSP config
require("grammar-guard").init()

require("lspconfig").grammar_guard.setup({
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown" },
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
