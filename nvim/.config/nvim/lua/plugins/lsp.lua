require("mason").setup(
  {
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  }
)

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
if project_name == "main" then
  project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:h:t')
end
local workspace_dir = '/var/home/mbarkmin/Sources/java-workspace/' .. project_name

require("mason-lspconfig").setup(
  {
    ensure_installed = {
      "tsserver", -- for javascript
      "jsonls", -- for json
      "jdtls", -- for java
      "texlab", -- for latex
      "ltex",
      "sqlls", -- for sql
      "pylsp", -- for python
      "lua_ls", -- for lua
      "gopls", -- for go
      "yamlls",
      "bashls",
      "dockerls",
      "html",
      "cssls",
      "marksman"
    }
  }
)

require("mason-lspconfig").setup_handlers {
  -- default handler - setup with default settings
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
  -- you can override the default handler by providing custom handlers per server
  ["jdtls"] = function()
    require("lspconfig").jdtls.setup {
      cmd = {
        -- 💀
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        -- 💀
        "-jar",
        "/var/home/mbarkmin/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
        "-configuration",
        "/var/home/mbarkmin/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data",
        workspace_dir
      },
      root_dir = require("lspconfig").util.root_pattern(
        ".git",
        "package.bluej",
        "gradlew",
        "settings.gradle",
        "settings.gradel.kts",
        "pom.xml",
        ".gitattributes"
      ) or vim.fn.getcwd(),
      single_file_support = true,
      settings = {
        java = {
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999
            }
          },
          project = {
            referencedLibraries = {
              "+libs/*.jar"
            }
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-11",
                path = "/var/home/mbarkmin/Applications/java/jdk-11/",
                default = true
              },
              {
                name = "JavaSE-17",
                path = "/var/home/mbarkmin/Applications/java/jdk-17.0.8+7/"
              },
              {
                name = "JavaSE-20",
                path = "/var/home/mbarkmin/Applications/java/jdk-20.0.1/"
              }
            }
          }
        }
      }
    }
  end,
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = {"vim"}
          }
        }
      }
    }
  end,
  ["texlab"] = function()
    require("lspconfig").texlab.setup {
      settings = {
        texlab = {
          auxDirectory = "build/pdf",
          chktex = {
            onEdit = true
          },
          build = {
            executable = "latexmk",
            forwardSearchAfter = false,
            onSave = false
          }
        }
      }
    }
  end,
  ["ltex"] = function()
    require("lspconfig").ltex.setup(
      {
        settings = {
          ltex = {
            enabled = {"latex", "tex", "bib", "markdown", "text", "txt"},
            diagnosticSeverity = "information",
            setenceCacheSize = 2000,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = "de"
            },
            trace = {server = "verbose"},
            dictionary = {},
            disabledRules = {},
            hiddenFalsePositives = {}
          }
        }
      }
    )
  end
}

-- options for lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    signs = true,
    update_in_insert = true,
    virtual_text = {
      true,
      spacing = 6
      --severity_limit='Error'  -- Only show virtual text on error
    }
  }
)

-- se LSP diagnostic symbols/signs
vim.api.nvim_command [[ sign define LspDiagnosticsSignError         text=✗ texthl=LspDiagnosticsSignError       linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignWarning       text=⚠ texthl=LspDiagnosticsSignWarning     linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignInformation   text= texthl=LspDiagnosticsSignInformation linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignHint          text= texthl=LspDiagnosticsSignHint        linehl= numhl= ]]
