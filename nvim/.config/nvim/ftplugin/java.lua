local root_markers = {
  'package.bluej',
  'settings.gradle',
  'settings.gradle.kts',
  'pom.xml',
  'build.gradle',
  'mvnw',
  'gradlew',
  'build.gradle',
  'build.gradle.kts',
  '.git',
}

local function find_root()
  return vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])
end

-- Determine if 'package.bluej' exists in the root directory
local root_dir = find_root()
local has_bluej_package = vim.fs.find('package.bluej', { path = root_dir, upward = false })[1] ~= nil

-- if create different project configurations for different root_dirs
local project = {
  sourcePaths = has_bluej_package and { '.' } or nil,
  referencedLibraries = {
    '+libs/**/*.jar',
  },
}

-- root_dir: scratch-for-java
if root_dir == vim.fn.expand '~/Sources/openpatch/scratch-for-java' then
  project.sourcePaths = { 'src', 'examples/java', 'examples/reference' }
  project.referencedLibraries = {
    'libs/**/*.jar',
  }
end

local config = {
  cmd = { '/usr/bin/jdtls' },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-25',
            path = '/home/mike/.sdkman/candidates/java/25-tem',
            default = true,
          },
          {
            name = 'JavaSE-21',
            path = '/home/mike/.sdkman/candidates/java/21-tem',
          },
          {
            name = 'JavaSE-17',
            path = '/home/mike/.sdkman/candidates/java/17.0.13-tem',
          },
        },
      },
      project = project,
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
    },
  },
}
require('jdtls').start_or_attach(config)
