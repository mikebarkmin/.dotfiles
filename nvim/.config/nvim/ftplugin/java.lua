
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
if project_name == "main" then
  project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:h:t")
end
local workspace_dir = "/var/home/mbarkmin/.local/share/java-workspace/" .. project_name

local config = {
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
  root_dir = require("jdtls.setup").find_root(
    {
      ".git",
      "package.bluej",
      "gradlew",
      "settings.gradle",
      "settings.gradel.kts",
      "pom.xml",
      ".gitattributes"
    }
  ),
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
          "+libs/*.jar",
          "libs/*.jar"
        }
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/var/home/mbarkmin/.sdkman/candidates/java/17.0.8.1-tem",
            default = true
          },
          {
            name = "JavaSE-11",
            path = "/var/home/mbarkmin/.sdkman/candidates/java/11.0.20.1-tem"
          }
        }
      }
    }
  },
  init_options = {
    bundles = {
      vim.fn.glob(
        "/var/home/mbarkmin/Sources/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        1
      )
    }
  }
}
require("jdtls").jol_path = "/var/home/mbarkmin/Applications/jol-cli-0.17-full.jar"
require("jdtls").start_or_attach(config)

local map = require("utils").map
map("n", "<Leader>vtc", "<cmd>lua require'jdtls'.test_class()<CR>")
map("n", "<Leader>vtm", "<cmd>lua require'jdtls'.test_nearest_method()<CR>")
